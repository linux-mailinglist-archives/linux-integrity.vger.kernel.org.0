Return-Path: <linux-integrity+bounces-6870-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B9B29515
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Aug 2025 22:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9CD3B8A97
	for <lists+linux-integrity@lfdr.de>; Sun, 17 Aug 2025 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03620A5EC;
	Sun, 17 Aug 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvDKNSQ+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F4C15573A;
	Sun, 17 Aug 2025 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755463369; cv=none; b=csxnHYwkml6rcR+0TnlhcSK7y4RtJJ7DVVRdgh/BMa4DUSVFu7HEyITixSeRX5AYbES1hgEj0E5ASWifIFAbO9YQpTzJvBL6qaEyrUoUMRdmfc7KXscV6HegDVZdpt6ZPUUNjRAVZ8JKhFBsRu3TRPnmJqV8R8hHuYFQ7Wplnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755463369; c=relaxed/simple;
	bh=CBPiooAGnayv+SiYVUC1qFMqyOwK0GLToyiu0GtI0DY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iEPxBTNzhr2zEbSIVuRTLmpK0f+SxnB/+8hZ8i2CdN6+62Z6VS6HWxRj/WpJ7NVcJyZRLGZkAY5gdpQTjUORULPp6UxiD9JDJVzTVXooeDZCgDULsWKXu6I0TR/EePgeBJGV/sil5sQHbGt8u8DhrCgBDQplMvOXRolaABOqSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvDKNSQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D8FC4CEEB;
	Sun, 17 Aug 2025 20:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755463369;
	bh=CBPiooAGnayv+SiYVUC1qFMqyOwK0GLToyiu0GtI0DY=;
	h=Date:From:To:Subject:From;
	b=pvDKNSQ+VSMqZokMerEYMXZ8Y5pIgzOaIG8Vs4n87HYwX+2hNPsPTAPtTzYg6yx2S
	 yA2TPObli6dTLIWDx5PbEIeiCFNrn5LeIusVLL+etm9TFQ1QORI7frBEN1vQWjv3wx
	 8ir7e7oI4VFZFaNFdI+oEOiowE82DLsO6JTvYeUR4VNws64KfipjwKp5o/1mccttdi
	 3o356ekEOFsAnzhCo4o+bTfEE1ONotXP7I4MKJ3pVD9YY4G6yvqnbNqKsykKhkIEKs
	 ddZeOg3goC+T+rM+5/j6oSURv1stq/W2AFnTwRxYO2ivC5ucDejmijhvo+DXqdRxzd
	 dgw1dTdGizQiA==
Date: Sun, 17 Aug 2025 23:42:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: tpm2@lists.linux.dev, linux-integrity@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: tpm2_protocol / tpm2sh 0.6.1
Message-ID: <aKI-xQsBNNvjeBSk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I tagged 0.6.0 release as I reached an important milestone i.e., now
Box<dyn TpmObject> is doable meaning that tpm2_protocol is capable of
dynamically interpreting on-wire TPM2 protocol traffic. It's proved by
this test:

https://github.com/puavo-org/tpm2_library/blob/main/tpm2sh/tests/dynamic.rs

This matters because it is the essence of being able to work as part
of driver, TPM emulator/chip or resource manager implementation.

This has required really going through the whole implementation and
deocoupling step by step the implementation from lifetime parameters
and finally implementing 'core::any::Any'.

Lot's of bugs have also been fixed in the protocol crate, tpm2sh crypto
module etc. The TCG specification coverage has increased and it is only
few dozen command/responses away from full TCG TPM 2.0 spec version 184
coverage. Given the efficient macro system this is coverage shortage
is mostly due lack of being more interested on more important matters.

My demo for this version is the cool pretty printer in tpm2sh :-)

~/work/github.com/jarkkojs/tpm2_library main
❯ sudo RUST_LOG=trace target/debug/tpm2sh --log-format pretty start-session --session-type policy  > /dev/null
2025-08-17T20:42:03.866947Z DEBUG cli::device: opening device_path=/dev/tpmrm0
⠋ Waiting for TPM...                                                                                                                                                   2025-08-17T20:42:03.867174Z TRACE cli::device: TPM_CC_StartAuthSession
2025-08-17T20:42:03.867205Z TRACE cli::device:   nonceCaller: (size=16) 0ce148fdde03544afc25024c9498ae48
2025-08-17T20:42:03.867212Z TRACE cli::device:   encryptedSalt: (size=0) 
2025-08-17T20:42:03.867217Z TRACE cli::device:   sessionType: Policy
2025-08-17T20:42:03.867221Z TRACE cli::device:   symmetric: TPM_ALG_NULL
2025-08-17T20:42:03.867225Z TRACE cli::device:   authHash: TPM_ALG_SHA256
⠏ ✔ TPM operation complete.                                                                                                                                            2025-08-17T20:42:03.899508Z TRACE cli::device: Response (rc=TPM_RC_SUCCESS)
2025-08-17T20:42:03.899563Z TRACE cli::device:   sessionHandle: 0x03000000
2025-08-17T20:42:03.899603Z TRACE cli::device:   nonceTpm: (size=16) 77ad71b0272d4d4dee6eee843e84bde1

~/work/github.com/jarkkojs/tpm2_library main
❯ sudo RUST_LOG=trace target/debug/tpm2sh --log-format pretty algorithms > /dev/null
2025-08-17T20:42:06.423983Z DEBUG cli::device: opening device_path=/dev/tpmrm0
⠋ Waiting for TPM...                                                                                                                                                   2025-08-17T20:42:06.424174Z TRACE cli::device: TPM_CC_GetCapability
2025-08-17T20:42:06.424185Z TRACE cli::device:   cap: TPM_CAP_ALGS
2025-08-17T20:42:06.424193Z TRACE cli::device:   property: 0x00000000
2025-08-17T20:42:06.424202Z TRACE cli::device:   propertyCount: 0x00000080
⠏ ✔ TPM operation complete.                                                                                                                                            2025-08-17T20:42:06.428085Z TRACE cli::device: Response (rc=TPM_RC_SUCCESS)
2025-08-17T20:42:06.428097Z TRACE cli::device:   moreData: TpmiYesNo(false)
2025-08-17T20:42:06.428105Z TRACE cli::device:   capabilityData:
2025-08-17T20:42:06.428111Z TRACE cli::device:     capability: TPM_CAP_ALGS
2025-08-17T20:42:06.428118Z TRACE cli::device:     data: (count=19)
2025-08-17T20:42:06.428127Z TRACE cli::device:       alg: TPM_ALG_RSA
2025-08-17T20:42:06.428147Z TRACE cli::device:       algProperties: ASYMMETRIC | OBJECT (0x9)
2025-08-17T20:42:06.428153Z TRACE cli::device:       alg: TPM_ALG_SHA1
2025-08-17T20:42:06.428160Z TRACE cli::device:       algProperties: HASH (0x4)
2025-08-17T20:42:06.428165Z TRACE cli::device:       alg: TPM_ALG_HMAC
2025-08-17T20:42:06.428172Z TRACE cli::device:       algProperties: HASH | SIGNING (0x104)
2025-08-17T20:42:06.428176Z TRACE cli::device:       alg: TPM_ALG_AES
2025-08-17T20:42:06.428184Z TRACE cli::device:       algProperties: SYMMETRIC (0x2)
2025-08-17T20:42:06.428189Z TRACE cli::device:       alg: TPM_ALG_KEYEDHASH
2025-08-17T20:42:06.428196Z TRACE cli::device:       algProperties: HASH | OBJECT | SIGNING | ENCRYPTING (0x30c)
2025-08-17T20:42:06.428204Z TRACE cli::device:       alg: TPM_ALG_XOR
2025-08-17T20:42:06.428210Z TRACE cli::device:       algProperties: SYMMETRIC | HASH (0x6)
2025-08-17T20:42:06.428215Z TRACE cli::device:       alg: TPM_ALG_SHA256
2025-08-17T20:42:06.428223Z TRACE cli::device:       algProperties: HASH (0x4)
2025-08-17T20:42:06.428229Z TRACE cli::device:       alg: TPM_ALG_RSASSA
2025-08-17T20:42:06.428236Z TRACE cli::device:       algProperties: ASYMMETRIC | SIGNING (0x101)
2025-08-17T20:42:06.428242Z TRACE cli::device:       alg: TPM_ALG_RSAES
2025-08-17T20:42:06.428249Z TRACE cli::device:       algProperties: ASYMMETRIC | ENCRYPTING (0x201)
2025-08-17T20:42:06.428255Z TRACE cli::device:       alg: TPM_ALG_RSAPSS
2025-08-17T20:42:06.428262Z TRACE cli::device:       algProperties: ASYMMETRIC | SIGNING (0x101)
2025-08-17T20:42:06.428267Z TRACE cli::device:       alg: TPM_ALG_OAEP
2025-08-17T20:42:06.428275Z TRACE cli::device:       algProperties: ASYMMETRIC | ENCRYPTING (0x201)
2025-08-17T20:42:06.428280Z TRACE cli::device:       alg: TPM_ALG_ECDSA
2025-08-17T20:42:06.428287Z TRACE cli::device:       algProperties: ASYMMETRIC | SIGNING | METHOD (0x501)
2025-08-17T20:42:06.428293Z TRACE cli::device:       alg: TPM_ALG_ECDH
2025-08-17T20:42:06.428300Z TRACE cli::device:       algProperties: ASYMMETRIC | METHOD (0x401)
2025-08-17T20:42:06.428305Z TRACE cli::device:       alg: TPM_ALG_ECDAA
2025-08-17T20:42:06.428312Z TRACE cli::device:       algProperties: ASYMMETRIC | SIGNING (0x101)
2025-08-17T20:42:06.428318Z TRACE cli::device:       alg: TPM_ALG_KDF1_SP800_56A
2025-08-17T20:42:06.428325Z TRACE cli::device:       algProperties: HASH | METHOD (0x404)
2025-08-17T20:42:06.428330Z TRACE cli::device:       alg: TPM_ALG_KDF1_SP800_108
2025-08-17T20:42:06.428337Z TRACE cli::device:       algProperties: HASH | METHOD (0x404)
2025-08-17T20:42:06.428343Z TRACE cli::device:       alg: TPM_ALG_ECC
2025-08-17T20:42:06.428350Z TRACE cli::device:       algProperties: ASYMMETRIC | OBJECT (0x9)
2025-08-17T20:42:06.428355Z TRACE cli::device:       alg: TPM_ALG_SYMCIPHER
2025-08-17T20:42:06.428362Z TRACE cli::device:       algProperties: OBJECT (0x8)
2025-08-17T20:42:06.428368Z TRACE cli::device:       alg: TPM_ALG_CFB
2025-08-17T20:42:06.428375Z TRACE cli::device:       algProperties: SYMMETRIC | ENCRYPTING (0x202)

BR, Jarkko

