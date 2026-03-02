Return-Path: <linux-integrity+bounces-8704-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEtzIUGapWnxEgYAu9opvQ
	(envelope-from <linux-integrity+bounces-8704-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 15:10:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C31DA698
	for <lists+linux-integrity@lfdr.de>; Mon, 02 Mar 2026 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E68E6303299C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Mar 2026 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B13FB076;
	Mon,  2 Mar 2026 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U2nbza5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0XwKXPg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8D3FB057;
	Mon,  2 Mar 2026 14:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460266; cv=none; b=E3yIbQK5XuarsrA6ZNijPhC8FkJQD6EZu/g+HffgsIDtnFoQ5kZcowy8T52vTuVpXeNCVGMtqAxzXL5UCsfN9xX6LJ4MIm2PjGH22LTi8HgLpckJ48ValcqN4Q2EgjsLG1B27Ayb0Lnjz5Vrzr78mJJH4HbVNXW3QCXYNP0nQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460266; c=relaxed/simple;
	bh=w7DXo3mXh6DNkAzYU9MYWlzqO/9Orncv55I/eELK7uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwR8AroBJOpiW9/Z+zWIDIFKttQYkJZ85xuqNreYzxrKHEJkaZuniPMiWPmrp6m4rIYYi8MOS0z8f7RjNyh9TZ9QEuLU2oAePyTprKdht7LGqiYIXU5FXRbPgevK8VWuge67UyFyKSDfpw3VPJ3s5aocW5M+gGDbYiKJLRP8wgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U2nbza5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0XwKXPg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Mar 2026 15:04:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772460261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRM2t72DmiN8sur4KC7kJvFl2g3W9LFFAmvpwZMN6BE=;
	b=U2nbza5Uj3+v1Yz/7NFP1KJEEu3qCsr7TJmPGA7AG/w/PFx5cPc1n3W7rsEmErqOZ4KQnZ
	UdxuiGENc2+EFgj42FJbMNjUVtRFJ/eqn7lvz517o7RfxxeptrK+1E7IhWU8U/EfnqWPhj
	5k+iAJ6aEN/kHFgi/PlYX7z3ixlVOLPpEisZdOuJIO9RpmyRAIZKSDNWru3XIgnQN5iT/Z
	oKatqMsKb6BNZZjY/bI/qPDPcoJj0X3J3HKrah6dzSwk6l79vbv6MGKSCaUPcHXpgwPtoB
	ng9u0ZkYA1egSpy0969/In5pa2B+//+adSoG0dZEnKVEternS8rsoVnVtPTNkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772460261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cRM2t72DmiN8sur4KC7kJvFl2g3W9LFFAmvpwZMN6BE=;
	b=O0XwKXPgKku1Br1+V/ezQXVmlbM/8IP4wwnZCgIuF89yo0/6aQDXPujJ+tjFwyLvfgYCyq
	HND4ATOem2K4dHCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: bot+bpf-ci@kernel.org
Cc: dhowells@redhat.com, dwmw2@infradead.org, mcgrof@kernel.org, 
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com, 
	atomlin@atomlin.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, nathan@kernel.org, 
	nsc@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, shuah@kernel.org, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 6/8] tools uapi headers: add linux/module_signature.h
Message-ID: <20260302150248-3bf0b0e6-ab1f-4808-905b-70c6ae1060e4@linutronix.de>
References: <20260302-module-signature-uapi-v1-6-207d955e0d69@linutronix.de>
 <b6c00e7ecc633ab02ee8689f5647ce9090cf72d75f5bf9f2cc2c09983d963b58@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c00e7ecc633ab02ee8689f5647ce9090cf72d75f5bf9f2cc2c09983d963b58@mail.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-8704-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-integrity,bpf-ci];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E95C31DA698
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 01:32:34PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/include/uapi/linux/module_signature.h b/tools/include/uapi/linux/module_signature.h
> > --- /dev/null
> > +++ b/tools/include/uapi/linux/module_signature.h
> 
> [ ... ]
> 
> > +enum module_signature_type {
> > +	MODULE_SIGNATURE_TYPE_PKCS7 = 2,	/* Signature in PKCS#7 message */
> > +	MODULE_SIGNATURE_TYPE_MERKLE = 3,	/* Merkle proof for modules */
> > +};
> 
> The source UAPI header at include/uapi/linux/module_signature.h does not
> define MODULE_SIGNATURE_TYPE_MERKLE:
> 
> include/uapi/linux/module_signature.h:
>     enum module_signature_type {
>         MODULE_SIGNATURE_TYPE_PKCS7 = 2,
>     };
> 
> Was this value intentionally added here ahead of the kernel header?  It
> appears to come from the CONFIG_MODULE_HASHES series referenced in the
> cover letter, but no commit in this series adds it to the kernel UAPI
> header, so the tools copy diverges from its source at creation time.

Indeed, this should only appear in the follow-up CONFIG_MODULE_HASHES series.
I'll fix it for v2.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22577240517
> 
> AI-authorship-score: low
> AI-authorship-explanation: Straightforward mechanical UAPI header copy with terse commit message, consistent with experienced kernel developer style from a known Linutronix contributor.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: The tools UAPI copy contains an enum value (MODULE_SIGNATURE_TYPE_MERKLE) not present in the kernel source header, creating a content mismatch that does not affect runtime behavior but violates the convention that tools copies mirror kernel UAPI headers.


