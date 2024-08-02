Return-Path: <linux-integrity+bounces-3246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706C3946453
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE60282507
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2024 20:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE533DF;
	Fri,  2 Aug 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="q353Utpf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C74CE05
	for <linux-integrity@vger.kernel.org>; Fri,  2 Aug 2024 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630385; cv=none; b=d2On3IEYQnb1FdRTHyJSRnuuvTPDtdju9oaUqgW0SKo4odrPHY1eBlXHfGngSUhjnpb0+DcL2bRoV3KJl/krGZN1pY+hJaYX+iNvKZYU7i9aVpVGj0Uc6DrDWuK2IMMTxQQGNMCybTGDYXXtNd+URIn4G/SfqCgNzsZlSVaSBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630385; c=relaxed/simple;
	bh=e1BaOhYB7z0J2l6xojIvWZk5WJoXeZ0vbypRislG9uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Om/aN8bn+XVCziT5kxyExdR2Jkl+4uLdbThOcHJCfuoZ/bCcdneZfKf0WoIql6ggjz89VJQoGSB2873f3G/WQL3gebFPOrDUzx8e81LXc6roeVm/i0FJgOO7/cu7LojuyP79Hisr5jGd+X+kAa6BsJEupHF4GFdHr8ZNpuX2ggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=q353Utpf; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722630383;
	bh=e1BaOhYB7z0J2l6xojIvWZk5WJoXeZ0vbypRislG9uo=;
	h=From:To:Subject:Date:Message-Id:From;
	b=q353Utpf7i3SAAJPFvemRgdb2BjERADKnOAPC0m3WtdkuNFkwy1I8kwmXhUyTct5l
	 zehP6hiyAVhQPc8iFmguVOhInIi7XaOV6+cTr5ontbPdSSaFk9W67G8rHONzrlIjQq
	 suxs24ztMT5s66pZVS3ekFXB2v16UKlCZKnt38V4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4A5671286A6B;
	Fri, 02 Aug 2024 16:26:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xGj7usumZNF5; Fri,  2 Aug 2024 16:26:23 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id B5374128690C;
	Fri, 02 Aug 2024 16:26:22 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: openssl-tpm2-engine@groups.io
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 0/8] openssl_tpm2_engine: Add attestation functions for primary keys
Date: Fri,  2 Aug 2024 16:25:58 -0400
Message-Id: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 5 patches add supporting infrastructure and the next three
add the actually attestation command, its man page and its tests.

The design is to be able to store a stable copy of the signing EK
(done by name) in /etc/eksign.name, which can then be used to verify
any on the fly creation of the signing key.  The reason for using a
signing EK not an AK as the specs usually require is to have the
simplicity of a stable key that never changes as the attesting key and
because there are no privacy issues in the machine owner knowing it.
The command then provides a way to attest this key against the EK
certificate (if the TPM has one).  If there is no EK certificate, the
signing EK name is used on a trust on first use (TOFU) basis.

attest_tpm2_primary --eksign > /etc/eksign.name

Will create this file once.  If an EK certificate exists, the
eksign.name file can be attested to that certificate with

attest_tpm2_primary --attest tpm-cert.crt --name /etc/eksign.name

The above commands should only need to be done once per TPM.

Once the Signing EK is known, it can be used on every boot to create
and certify the NULL key, which is what the kernel uses and exports
from version 6.10 onwards and thus proves to the user that the
kernel's reliance on the NULL key during boot was cryptographically
justifed.  This can be done from a boot script as:

attest_tpm2_primary --certify null --name /etc/eksign.name /sys/class/tpm/tpm0/null_name

Which will return true if the certification succeeds.  If the
certification fails, all TPM functions should be considered
compromised.  Whether boot should continue even with a compromised TPM
is a user policy decision.

James

---

James Bottomley (8):
  tss: Fix handling of TPM_RH_NULL in intel-tss
  libcommon: add ability to create a signing primary key
  libcommon: add bin2hex and tmp2_get_hexname
  libcommon: add primary creation from template
  tss: add tpm2_Certify, tpm2_ActivateCredential and tpm2_PolicyOR
  tools: add new attest_tpm2_primary command
  attest_tpm2_primary: add man page
  tests: add tests for attest_tpm2_primary

 src/include/ibm-tss.h              |  84 +++
 src/include/intel-tss.h            |  95 +++-
 src/include/tpm2-common.h          |   9 +
 src/libcommon/tpm2-common.c        |  93 +++-
 src/tools/Makefile.am              |  11 +-
 src/tools/attest_tpm2_primary.1.in | 103 ++++
 src/tools/attest_tpm2_primary.c    | 842 +++++++++++++++++++++++++++++
 tests/attestation.sh               |  30 +
 tests/check_importable.sh          |   3 +-
 tests/engine/Makefile.am           |   3 +-
 tests/provider/Makefile.am         |   3 +-
 tests/seal_unseal.sh               |   3 +-
 tests/start_sw_tpm.sh              |   2 +
 13 files changed, 1230 insertions(+), 51 deletions(-)
 create mode 100644 src/tools/attest_tpm2_primary.1.in
 create mode 100644 src/tools/attest_tpm2_primary.c
 create mode 100755 tests/attestation.sh

-- 
2.35.3


