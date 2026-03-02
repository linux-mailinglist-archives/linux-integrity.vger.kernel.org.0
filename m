Return-Path: <linux-integrity+bounces-8703-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMvrKiuTpWnXEAYAu9opvQ
	(envelope-from <linux-integrity+bounces-8703-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 14:39:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D71D9F49
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B7AD307C436
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC53FB07C;
	Mon,  2 Mar 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEL+VDLf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8113ED11C;
	Mon,  2 Mar 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458356; cv=none; b=ry6tllnqMMBcb64Pc+bYD3ZjZMPHf3uzTw/OcdpFNrZ1MhEDrIdzNdPPHoSf1WhMh3+OIauPjEvmM7JOO3OImnfj0/LQ5LlV0JvmT7j0zGSPyb4tmz74LW92qyVDwOiYYhW2/LeVQrxUawbRS47YJ5fV1kGBnCXFISbEK46UgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458356; c=relaxed/simple;
	bh=MMO6QzhJTBpjIamFxQOPnoG0lDTOenIytlKAn/pj/E4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kGVnpRHOJ5g9uDKp/8dLcObeRF3KRaqAECu8g1PgyBPrRRonFsb9YuhUW/ThrGBTEudCJ0QYZ5TUHG7VeioYf3Ie8u9IdWMC0mW6xUErNhxtqdQqu+Q6f8wwlKKD8GQrQvEC4IRwpkD4AH+xTik24qkusez9z5B3kRmikGooHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEL+VDLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17BBC2BCAF;
	Mon,  2 Mar 2026 13:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772458355;
	bh=MMO6QzhJTBpjIamFxQOPnoG0lDTOenIytlKAn/pj/E4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=fEL+VDLfWgejB2UiD3yfu4w39ugAxlb20659+wBdunWi1Bmc39BavexRTwtcs+1l3
	 sX93ULfh/tz4Vhr0v3imaxSkT35vp3EVg9Gy+LgXN+2mq96c3xiAwr/WyFIihORW9w
	 BGpyRT/a1j1nBY0ZjXH/GPrvJyTo9mEc3DN+Xka8m1xkvcDYFegbdDh9ZTD8HmUkK0
	 nxghDIgYeXQX0sbRhzs9+fSGH8XrM7dswPU2XpiF4ZdmAB25gPYcvE+LjIAqNBNgUi
	 +UUD9qGbudgTDkVZ7YshLPbkpT5245i6bbuZy3My6iob9UzGq4b2JfAUxFrzM/2uTT
	 vDicKTI56lTsw==
Content-Type: multipart/mixed; boundary="===============7930476675043711056=="
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b6c00e7ecc633ab02ee8689f5647ce9090cf72d75f5bf9f2cc2c09983d963b58@mail.kernel.org>
In-Reply-To: <20260302-module-signature-uapi-v1-6-207d955e0d69@linutronix.de>
References: <20260302-module-signature-uapi-v1-6-207d955e0d69@linutronix.de>
Subject: Re: [PATCH 6/8] tools uapi headers: add linux/module_signature.h
From: bot+bpf-ci@kernel.org
To: thomas.weissschuh@linutronix.de,dhowells@redhat.com,dwmw2@infradead.org,mcgrof@kernel.org,petr.pavlu@suse.com,da.gomez@kernel.org,samitolvanen@google.com,atomlin@atomlin.com,hca@linux.ibm.com,gor@linux.ibm.com,agordeev@linux.ibm.com,borntraeger@linux.ibm.com,svens@linux.ibm.com,zohar@linux.ibm.com,roberto.sassu@huawei.com,dmitry.kasatkin@gmail.com,eric.snowberg@oracle.com,paul@paul-moore.com,jmorris@namei.org,serge@hallyn.com,nathan@kernel.org,nsc@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org
Cc: keyrings@vger.kernel.org,linux-kernel@vger.kernel.org,linux-modules@vger.kernel.org,linux-s390@vger.kernel.org,linux-integrity@vger.kernel.org,linux-security-module@vger.kernel.org,linux-kbuild@vger.kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,thomas.weissschuh@linutronix.de,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 13:32:34 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,linux-integrity@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8703-lists,linux-integrity=lfdr.de,bpf-ci];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linutronix.de,redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 236D71D9F49
X-Rspamd-Action: no action

--===============7930476675043711056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/include/uapi/linux/module_signature.h b/tools/include/uapi/linux/module_signature.h
> --- /dev/null
> +++ b/tools/include/uapi/linux/module_signature.h

[ ... ]

> +enum module_signature_type {
> +	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
> +	MODULE_SIGNATURE_TYPE_MERKLE = 3,	/* Merkle proof for modules */
> +};

The source UAPI header at include/uapi/linux/module_signature.h does not
define MODULE_SIGNATURE_TYPE_MERKLE:

include/uapi/linux/module_signature.h:
    enum module_signature_type {
        MODULE_SIGNATURE_TYPE_PKCS7 = 2,
    };

Was this value intentionally added here ahead of the kernel header?  It
appears to come from the CONFIG_MODULE_HASHES series referenced in the
cover letter, but no commit in this series adds it to the kernel UAPI
header, so the tools copy diverges from its source at creation time.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22577240517

AI-authorship-score: low
AI-authorship-explanation: Straightforward mechanical UAPI header copy with terse commit message, consistent with experienced kernel developer style from a known Linutronix contributor.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The tools UAPI copy contains an enum value (MODULE_SIGNATURE_TYPE_MERKLE) not present in the kernel source header, creating a content mismatch that does not affect runtime behavior but violates the convention that tools copies mirror kernel UAPI headers.

--===============7930476675043711056==--

