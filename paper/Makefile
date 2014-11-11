figures = \
		figures/bimodal_clusters.pdf \
		figures/operation_mixed_clusters.pdf \
		figures/weird_lol_clusters.pdf \
		figures/weird_so_clusters.pdf \
		figures/bimodals_clusters.pdf \
		figures/trimodal_clusters.pdf \
		figures/weird_so_answer_clusters.pdf \
		figures/weird_so_question_clusters.pdf

parts = \
		parts/abstract.tex \
		parts/authors.tex \
		parts/body.tex \
		parts/util.tex

sections = \
		sections/acknowledgements.tex \
		sections/human_activities.tex \
		sections/implications_and_future_work.tex \
		sections/introduction.tex \
		sections/methods.tex \
		sections/results_and_discussion.tex \
		sections/session_identification.tex

tables = tables/fits.tex


halfaker2014user.pdf: halfaker2014user.tex $(figures) $(parts) $(sections) \
		$(tables)
	rubber --pdf halfaker2014user.tex

halfaker2014user.arxiv.pdf: halfaker2014user.arxiv.tex $(figures) $(parts) \
	 	$(sections) $(tables)
	rubber --pdf halfaker2014user.arxiv.tex

halfaker2014user.arxiv.tar.gz: halfaker2014user.arxiv.pdf sig-alternate.cls
	tar -zcf halfaker2014user.arxiv.tar.gz \
			halfaker2014user.arxiv.* sig-alternate.cls figures parts sections\
			tables
