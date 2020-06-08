default: docker-run

all: docker-build docker-run

pristine: clean clean-sources fetch-sources docker-build docker-run

docker-build: docker-build-android docker-build-ios
docker-build-android:
	docker build . -t svg-to-android -f Dockerfile.android
docker-build-ios:
	docker build . -t svg-to-ios -f Dockerfile.ios

docker-run: docker-run-android docker-run-ios
docker-run-android:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-android
docker-run-ios:
	docker run --rm -it  -v $$(PWD)/mounts/input:/mounts/input -v $$(PWD)/mounts/output:/mounts/output svg-to-ios

clean: clean-android clean-ios
clean-android:
	rm -rf mounts/output/android/*
clean-ios:
	rm -rf mounts/output/ios/*

clean-sources:
	rm -rf src/main/java/com/android

fetch-sources: clean-sources
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/Svg2Vector.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgTree.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/SvgTree.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/PathBuilder.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/SvgGroupNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgNode.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/SvgNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgColor.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/SvgColor.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgClipPathNode.java;hb=master'				-o src/main/java/com/android/ide/common/vectordrawable/SvgClipPathNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdUtil.kt;hb=master'							-o src/main/java/com/android/ide/common/vectordrawable/VdUtil.kt
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgGradientNode.java;hb=master'				-o src/main/java/com/android/ide/common/vectordrawable/SvgGradientNode.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/VdNodeRender.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/PathParser.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/PathParser.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdPath.java;hb=master'							-o src/main/java/com/android/ide/common/vectordrawable/VdPath.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/GradientStop.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/GradientStop.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/VdElement.java;hb=master'						-o src/main/java/com/android/ide/common/vectordrawable/VdElement.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/EllipseSolver.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/EllipseSolver.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/ResourcesNotSupportedException.java;hb=master'	-o src/main/java/com/android/ide/common/vectordrawable/ResourcesNotSupportedException.java
	mkdir -p src/main/java/com/android/ide/common/vectordrawable && curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=sdk-common/src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java;hb=master'					-o src/main/java/com/android/ide/common/vectordrawable/SvgLeafNode.java

	mkdir -p src/main/java/com/android					&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/SdkConstants.java;hb=master'							-o src/main/java/com/android/SdkConstants.java
	mkdir -p src/main/java/com/android/support			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/support/AndroidxName.java;hb=master'					-o src/main/java/com/android/support/AndroidxName.java
	mkdir -p src/main/java/com/android/support			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/support/AndroidxNameUtils.java;hb=master'				-o src/main/java/com/android/support/AndroidxNameUtils.java
	mkdir -p src/main/java/com/android/support			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/support/AndroidxMigrationParser.kt;hb=master'			-o src/main/java/com/android/support/AndroidxMigrationParser.kt
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/XmlUtils.java;hb=master'						-o src/main/java/com/android/utils/XmlUtils.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/PositionXmlParser.java;hb=master'				-o src/main/java/com/android/utils/PositionXmlParser.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/ide/common/blame/SourcePosition.java;hb=master'		-o src/main/java/com/android/ide/common/blame/SourcePosition.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/ide/common/blame/SourceFilePosition.java;hb=master'	-o src/main/java/com/android/ide/common/blame/SourceFilePosition.java
	mkdir -p src/main/java/com/android/ide/common/blame	&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/ide/common/blame/SourceFile.java;hb=master'			-o src/main/java/com/android/ide/common/blame/SourceFile.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/Pair.java;hb=master'							-o src/main/java/com/android/utils/Pair.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/DecimalUtils.java;hb=master'					-o src/main/java/com/android/utils/DecimalUtils.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/CharSequences.java;hb=master'					-o src/main/java/com/android/utils/CharSequences.java
	mkdir -p src/main/java/com/android/utils			&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=common/src/main/java/com/android/utils/CharSequenceReader.java;hb=master'				-o	src/main/java/com/android/utils/CharSequenceReader.java

	mkdir -p src/main/java/com/android/annotations				&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=annotations/src/main/java/com/android/annotations/NonNull.java'				-o src/main/java/com/android/annotations/NonNull.java
	mkdir -p src/main/java/com/android/annotations				&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=annotations/src/main/java/com/android/annotations/Nullable.java'				-o src/main/java/com/android/annotations/Nullable.java
	mkdir -p src/main/java/com/android/annotations/concurrency	&& curl --silent 'http://git.jetbrains.org/?p=idea/adt-tools-base.git;a=blob_plain;f=annotations/src/main/java/com/android/annotations/concurrency/Immutable.java'	-o src/main/java/com/android/annotations/concurrency/Immutable.java
