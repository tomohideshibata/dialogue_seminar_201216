{
    "dataset_reader": {
        "type": "conll2003",
        "tag_label": "ner",
        "lazy": false,
	"token_indexers": {
            "tokens": {
                "type": "single_id"
            }
	}
    },
    "train_data_path": std.extVar("NER_TRAIN_DATA_PATH"),
    "validation_data_path": std.extVar("NER_VALID_DATA_PATH"),
    "model": {
        "type": "crf_tagger",
        "label_encoding": "BIO",
        "calculate_span_f1": true,
        "text_field_embedder": {
            "token_embedders": {
                "tokens": {
                    "type": "embedding",
		    "embedding_dim": 300,
		    "pretrained_file": "https://dl.fbaipublicfiles.com/fasttext/vectors-crawl/cc.ja.300.vec.gz",
		    "trainable": true
                }
            }
        },
        "encoder": {
           "type": "lstm",
           "input_size": 300,
           "hidden_size": 200,
	   "num_layers": 1,
	   "dropout": 0.5,
           "bidirectional": true
        },
    },
    "data_loader": {
        "batch_size": 32
    },
    "trainer": {
        "optimizer": {
            "type": "adam",
	    "lr": 0.001
        },
        "num_epochs": 50,
	"validation_metric": "+f1-measure-overall",
	"patience": 3,
        "cuda_device": 0
    }
}
