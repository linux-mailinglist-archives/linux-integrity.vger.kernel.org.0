Return-Path: <linux-integrity+bounces-8421-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDs7CtPngWl0LwMAu9opvQ
	(envelope-from <linux-integrity+bounces-8421-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:19:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90931D8E88
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6759B3069ED6
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCF33F8AE;
	Tue,  3 Feb 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S6jqY5Ov"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE0533D6DA
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121167; cv=none; b=e5UMA1sIJ2os0g1b9xdaIpoApbqQ3wL4ejHpzf9xZor1mdItWNjn9MyUIXjTQWapsc/89TNW3VmbpWRz3gOar9CkgxN8YH57edvRqyY5lF2mK/tk1OGquiWX9tGuPs62L6hI1BTm3n5OUeP8V5ZWZALAVmUNUElMOoOvpD8P/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121167; c=relaxed/simple;
	bh=mPLHFnGAiJZDNVZ0+nBky+Y2dBrJVcYPEEc9prrXLSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ksqEa5TKGw3giZ4AYvey/ifSVVC+pb3chuNYmZVjfqy/IWfSXN2WMvyYaXOzgIznLbP8QYTtc5CmVSK6jCXSD9hoZMnXc+MHI2wQTm1v3sfe9bCQ2AyQHjxU8rZfGWGWOs6ON+LsAG+pveeXZ1wduFmbDbW/4SGu36gvMwCB61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S6jqY5Ov; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso7521075e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 03 Feb 2026 04:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770121163; x=1770725963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6MzBps8jkAvm9TbR+DQoEBSa7zCEs2ceIfky0NJtjA=;
        b=S6jqY5OvID7eAjHD1GMyte32Kq7NKfuH3rMGB0kRO6f6uAhpS+tac8RS3pkoHvBa5N
         SIFWP9qvH8rsk4QHvl0qzGMzH5FbXrhCrTeZS8FCWmfL6SBEQ7dfSvmXkcUQx546Eu7H
         M/b8Ebfm05YHeLqfyA7PFjERblgYCF25eqLOch3EGua+g9focfisbx/7eEd5mtJxVEwH
         Dz8guhzjht+vOwEgQfAtYF87NWCTJM4HNBzHhvNxfEhbsUBgt0tVFQDUR4hl0x/pT3rr
         M59odhU80Eyu4A2GPhzJ4ddploWCqHW4TWmK8pRE/DvY0tyY/4HS/BmZNvFOQU95e4DE
         NDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121163; x=1770725963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6MzBps8jkAvm9TbR+DQoEBSa7zCEs2ceIfky0NJtjA=;
        b=rG5sg9Nx2JhAIrigVOG+11ujaQupQPXWdxggCKEC1ecorvMH3qpcIJzbXK8Gpeilcc
         vgSclDJl6sI+lsKblV0KHQ+bbOnlxLdjSE1NgR6f/qrUvR+pNY0RUtAY9hVBnJpmQbM6
         cQYBIq/CIC0nqSZES58gVNbfyXjtFevN6r8trlIVbzWGobrc3Fb0s7SitR9ORzXwmZBL
         OV2Hzk3BmMepzh2NscCPayLJ93E54wM2f3OsUkqMKyD2gQX4k8RijXCN9YcywLC/tW57
         N80UToVsjw0Y0AhcdN3z2rzrw2H18L1eRfsuWeJ57mn1ysdZPBzXeW+CINMi+dA74L/y
         1eZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9RoP0ywMS6PjGDBBb0GQkuD15pRBNHKwzx0pMwKS98mrkNIZOURDW35l0LRH1wavZar5u6ROC9RUtj1YfxJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1RdxCB2eIrTRTfxF6RR6cWYld+wX9AoVlQQkB+X1f6Xf53+TH
	DpJUSvWr9VG0W54UvwbdozAbCPv/4B1fDv9rHTUy5r2C+jFBWvUcLCxCundwxJeIkOQ=
X-Gm-Gg: AZuq6aK6wlAu6J4hNfgvKGYCI9UzzVrblG3XGG+peR+if0OckTxjRNK/3Ez+n1F4lYf
	V8jFa99amHiaXrL1tqawXkg6Taj5DpDDXOj3Lo3zDiM5uFuSuQDE5M/TrtsORBHTOzgnIPJj81f
	EXoYIq/nfMikMIdKZo41F8+0WVj+DW+JICbIoJq14aPQkZUXA9MmpSfQUnAtdFPtEiUTA7TiBcV
	mtSDgWeVPu1dp5DG1iyFmGgzbGNiNVaQsHfxX5qLm/QsWO0xlocdQrbkY0RY/Ea8xLlOZDoKCmE
	TnCu0plIBuiLdfk9tCQbiL1/Otrt3DQtYG+6W48hYevAF4LtfyHzyUtPbXX5MbEgIo7nt778KXk
	BMs4J0xFNFvvysN+sDJYP780vDgb5OaG2u7q/EENRRsmlQVjCxrd7YI/Bij0ep7DCwxQvQy7YAn
	i8vkWoMWdhUOvatNq8uCcU4XKzsGt2iA==
X-Received: by 2002:a05:600c:4f4f:b0:47d:6c36:a125 with SMTP id 5b1f17b1804b1-483051553a4mr44296785e9.17.1770121162686;
        Tue, 03 Feb 2026 04:19:22 -0800 (PST)
Received: from [10.0.1.22] (109-81-1-107.rct.o2.cz. [109.81.1.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483051287cfsm96086105e9.6.2026.02.03.04.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 04:19:22 -0800 (PST)
Message-ID: <fab2af64-e396-45f9-8876-feff4002e04b@suse.com>
Date: Tue, 3 Feb 2026 13:19:20 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Nicolas Schier <nicolas.schier@linux.dev>, Daniel Gomez
 <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Nicolas Schier <nsc@kernel.org>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 =?UTF-8?Q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>,
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>,
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>,
 =?UTF-8?Q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-8421-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petr.pavlu@suse.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim,breakpoint.cc:email]
X-Rspamd-Queue-Id: 90931D8E88
X-Rspamd-Action: no action

On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.
> 
> Non-builtin modules can be validated as before through signatures.
> 
> Normally the .ko module files depend on a fully built vmlinux to be
> available for modpost validation and BTF generation. With
> CONFIG_MODULE_HASHES, vmlinux now depends on the modules
> to build a merkle tree. This introduces a dependency cycle which is
> impossible to satisfy. Work around this by building the modules during
> link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
> but before the final module hashes are
> 
> The PKCS7 format which is used for regular module signatures can not
> represent Merkle proofs, so a new kind of module signature is
> introduced. As this signature type is only ever used for builtin
> modules, no compatibility issues can arise.

Nit: The description uses the term "builtin modules" in a misleading
way. Typically, "builtin modules" refers to modules that are linked
directly into vmlinux. However, this text uses the term to refer to
loadable modules that are built together with the main kernel image,
which is something different.

> diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> new file mode 100644
> index 000000000000..a6ec0e21213b
> --- /dev/null
> +++ b/scripts/modules-merkle-tree.c
> @@ -0,0 +1,467 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Compute hashes for modules files and build a merkle tree.
> + *
> + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> + * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
> + *
> + */
> +#define _GNU_SOURCE 1
> +#include <arpa/inet.h>
> +#include <err.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdarg.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include <stdlib.h>
> +
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +
> +#include <openssl/evp.h>
> +#include <openssl/err.h>
> +
> +#include "ssl-common.h"
> +
> +static int hash_size;
> +static EVP_MD_CTX *ctx;
> +
> +struct module_signature {
> +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> +	uint8_t		hash;		/* Digest algorithm [0] */
> +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> +	uint8_t		signer_len;	/* Length of signer's name [0] */
> +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> +	uint8_t		__pad[3];
> +	uint32_t	sig_len;	/* Length of signature data */
> +};
> +
> +#define PKEY_ID_MERKLE 3
> +
> +static const char magic_number[] = "~Module signature appended~\n";

It might make sense to put these common structures into a file under
scripts/include/ so they can be shared by both scripts/sign-file.c and
scripts/modules-merkle-tree.c.

> +
> +struct file_entry {
> +	char *name;
> +	unsigned int pos;
> +	unsigned char hash[EVP_MAX_MD_SIZE];
> +};
> +
> +static struct file_entry *fh_list;
> +static size_t num_files;
> +
> +struct leaf_hash {
> +	unsigned char hash[EVP_MAX_MD_SIZE];
> +};
> +
> +struct mtree {
> +	struct leaf_hash **l;
> +	unsigned int *entries;
> +	unsigned int levels;
> +};
> +
> +static inline void *xcalloc(size_t n, size_t size)
> +{
> +	void *p;
> +
> +	p = calloc(n, size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static void *xmalloc(size_t size)
> +{
> +	void *p;
> +
> +	p = malloc(size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static inline void *xreallocarray(void *oldp, size_t n, size_t size)
> +{
> +	void *p;
> +
> +	p = reallocarray(oldp, n, size);
> +	if (!p)
> +		errx(1, "Memory allocation failed");
> +
> +	return p;
> +}
> +
> +static inline char *xasprintf(const char *fmt, ...)
> +{
> +	va_list ap;
> +	char *strp;
> +	int ret;
> +
> +	va_start(ap, fmt);
> +	ret = vasprintf(&strp, fmt, ap);
> +	va_end(ap);
> +	if (ret == -1)
> +		err(1, "Memory allocation failed");
> +
> +	return strp;
> +}

I believe it is preferable to use xmalloc() and related functions from
scripts/include/xalloc.h, instead of defining your own variants. If
something is missing in xalloc.h, it can be extended.

> +
> +static unsigned int get_pow2(unsigned int val)
> +{
> +	return 31 - __builtin_clz(val);
> +}
> +
> +static unsigned int roundup_pow2(unsigned int val)
> +{
> +	return 1 << (get_pow2(val - 1) + 1);
> +}
> +
> +static unsigned int log2_roundup(unsigned int val)
> +{
> +	return get_pow2(roundup_pow2(val));
> +}

In the edge case when the kernel is built with only one module, the code
calls log2_roundup(1) -> roundup_pow2(1) -> get_pow2(0) ->
__builtin_clz(0). The return value of __builtin_clz() is undefined if
the input is zero.

> +
> +static void hash_data(void *p, unsigned int pos, size_t size, void *ret_hash)
> +{
> +	unsigned char magic = 0x01;
> +	unsigned int pos_be;
> +
> +	pos_be = htonl(pos);
> +
> +	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
> +	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
> +	ERR(EVP_DigestUpdate(ctx, &pos_be, sizeof(pos_be)) != 1, "EVP_DigestUpdate(pos)");
> +	ERR(EVP_DigestUpdate(ctx, p, size) != 1, "EVP_DigestUpdate(data)");
> +	ERR(EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1, "EVP_DigestFinal_ex()");
> +}
> +
> +static void hash_entry(void *left, void *right, void *ret_hash)
> +{
> +	int hash_size = EVP_MD_CTX_get_size_ex(ctx);

Nit: The local variable hash_size can be removed, as the static variable
with the same name should hold the same value.

> +	unsigned char magic = 0x02;
> +
> +	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
> +	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
> +	ERR(EVP_DigestUpdate(ctx, left, hash_size) != 1, "EVP_DigestUpdate(left)");
> +	ERR(EVP_DigestUpdate(ctx, right, hash_size) != 1, "EVP_DigestUpdate(right)");
> +	ERR(EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1, "EVP_DigestFinal_ex()");
> +}
> +
> +static void hash_file(struct file_entry *fe)
> +{
> +	struct stat sb;
> +	int fd, ret;
> +	void *mem;
> +
> +	fd = open(fe->name, O_RDONLY);
> +	if (fd < 0)
> +		err(1, "Failed to open %s", fe->name);
> +
> +	ret = fstat(fd, &sb);
> +	if (ret)
> +		err(1, "Failed to stat %s", fe->name);
> +
> +	mem = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
> +	close(fd);
> +
> +	if (mem == MAP_FAILED)
> +		err(1, "Failed to mmap %s", fe->name);

Nit: The err() call should be moved immediately after mmap(). In theory,
the interleaving close() could change the errno value, resulting in
err() printing a misleading error message.

> +
> +	hash_data(mem, fe->pos, sb.st_size, fe->hash);
> +
> +	munmap(mem, sb.st_size);
> +}
> +
> +static struct mtree *build_merkle(struct file_entry *fh, size_t num)
> +{
> +	struct mtree *mt;
> +	unsigned int le;
> +
> +	if (!num)
> +		return NULL;
> +
> +	mt = xmalloc(sizeof(*mt));
> +	mt->levels = log2_roundup(num);
> +
> +	mt->l = xcalloc(sizeof(*mt->l), mt->levels);
> +
> +	mt->entries = xcalloc(sizeof(*mt->entries), mt->levels);
> +	le = num / 2;
> +	if (num & 1)
> +		le++;
> +	mt->entries[0] = le;
> +	mt->l[0] = xcalloc(sizeof(**mt->l), le);
> +
> +	/* First level of pairs */
> +	for (unsigned int i = 0; i < num; i += 2) {
> +		if (i == num - 1) {
> +			/* Odd number of files, no pair. Hash with itself */
> +			hash_entry(fh[i].hash, fh[i].hash, mt->l[0][i / 2].hash);
> +		} else {
> +			hash_entry(fh[i].hash, fh[i + 1].hash, mt->l[0][i / 2].hash);
> +		}
> +	}
> +	for (unsigned int i = 1; i < mt->levels; i++) {
> +		int odd = 0;
> +
> +		if (le & 1) {
> +			le++;
> +			odd++;
> +		}
> +
> +		mt->entries[i] = le / 2;
> +		mt->l[i] = xcalloc(sizeof(**mt->l), le);

l[i] is overallocated. It needs only 'le / 2' entries.

> +
> +		for (unsigned int n = 0; n < le; n += 2) {
> +			if (n == le - 2 && odd) {
> +				/* Odd number of pairs, no pair. Hash with itself */
> +				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n].hash,
> +					   mt->l[i][n / 2].hash);
> +			} else {
> +				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n + 1].hash,
> +					   mt->l[i][n / 2].hash);
> +			}
> +		}
> +		le =  mt->entries[i];

Nit: It might be helpful to write both the first-level and other-level
loops in the same style to make them easier to understand, perhaps by
clearly separating the number of entries at each level. I suggest
something like the following:

static struct mtree *build_merkle(struct file_entry *fh, size_t num_files)
{
	struct mtree *mt;
	unsigned int num_cur_le, num_prev_le;

	if (!num_files)
		return NULL;

	mt = xmalloc(sizeof(*mt));
	mt->levels = log2_roundup(num_files);

	mt->l = xcalloc(sizeof(*mt->l), mt->levels);

	mt->entries = xcalloc(sizeof(*mt->entries), mt->levels);
	num_cur_le = (num_files + 1) / 2;
	mt->entries[0] = num_cur_le;
	mt->l[0] = xcalloc(sizeof(**mt->l), num_cur_le);

	/* First level of pairs */
	for (unsigned int i = 0; i < num_files; i += 2) {
		/* Hash the pair, or the last file with itself if it's odd. */
		void *right = i + 1 < num_files ? fh[i + 1].hash : fh[i].hash;
		hash_entry(fh[i].hash, right, mt->l[0][i / 2].hash);
	}

	for (unsigned int i = 1; i < mt->levels; i++) {
		num_prev_le = num_cur_le;

		num_cur_le = (num_prev_le + 1) / 2;
		mt->entries[i] = num_cur_le;
		mt->l[i] = xcalloc(sizeof(**mt->l), num_cur_le);

		for (unsigned int n = 0; n < num_prev_le; n += 2) {
			/* Hash the pair, or the last with itself if it's odd. */
			void *right = n + 1 < num_prev_le ?
					      mt->l[i - 1][n + 1].hash :
					      mt->l[i - 1][n].hash;
			hash_entry(mt->l[i - 1][n].hash, right,
				   mt->l[i][n / 2].hash);
		}
	}
	return mt;
}

> +	}
> +	return mt;
> +}
> +
> +static void free_mtree(struct mtree *mt)
> +{
> +	if (!mt)
> +		return;
> +
> +	for (unsigned int i = 0; i < mt->levels; i++)
> +		free(mt->l[i]);
> +
> +	free(mt->l);
> +	free(mt->entries);
> +	free(mt);
> +}
> +
> +static void write_be_int(int fd, unsigned int v)
> +{
> +	unsigned int be_val = htonl(v);
> +
> +	if (write(fd, &be_val, sizeof(be_val)) != sizeof(be_val))
> +		err(1, "Failed writing to file");
> +}
> +
> +static void write_hash(int fd, const void *h)
> +{
> +	ssize_t wr;
> +
> +	wr = write(fd, h, hash_size);
> +	if (wr != hash_size)
> +		err(1, "Failed writing to file");
> +}

Nit: This could be

if (write(fd, h, hash_size) != hash_size)

to keep the style of write_be_int() and write_hash() consistent.

> +
> +static void build_proof(struct mtree *mt, unsigned int n, int fd)
> +{
> +	unsigned char cur[EVP_MAX_MD_SIZE];
> +	unsigned char tmp[EVP_MAX_MD_SIZE];
> +	struct file_entry *fe, *fe_sib;
> +
> +	fe = &fh_list[n];
> +
> +	if ((n & 1) == 0) {
> +		/* No pair, hash with itself */
> +		if (n + 1 == num_files)
> +			fe_sib = fe;
> +		else
> +			fe_sib = &fh_list[n + 1];
> +	} else {
> +		fe_sib = &fh_list[n - 1];
> +	}
> +	/* First comes the node position into the file */
> +	write_be_int(fd, n);
> +
> +	if ((n & 1) == 0)
> +		hash_entry(fe->hash, fe_sib->hash, cur);
> +	else
> +		hash_entry(fe_sib->hash, fe->hash, cur);
> +
> +	/* Next is the sibling hash, followed by hashes in the tree */
> +	write_hash(fd, fe_sib->hash);
> +
> +	for (unsigned int i = 0; i < mt->levels - 1; i++) {
> +		n >>= 1;
> +		if ((n & 1) == 0) {
> +			void *h;
> +
> +			/* No pair, hash with itself */
> +			if (n + 1 == mt->entries[i])
> +				h = cur;
> +			else
> +				h = mt->l[i][n + 1].hash;
> +
> +			hash_entry(cur, h, tmp);
> +			write_hash(fd, h);
> +		} else {
> +			hash_entry(mt->l[i][n - 1].hash, cur, tmp);
> +			write_hash(fd, mt->l[i][n - 1].hash);
> +		}
> +		memcpy(cur, tmp, hash_size);
> +	}
> +
> +	 /* After all that, the end hash should match the root hash */
> +	if (memcmp(cur, mt->l[mt->levels - 1][0].hash, hash_size))
> +		errx(1, "hash mismatch");
> +}
> +
> +static void append_module_signature_magic(int fd, unsigned int sig_len)
> +{
> +	struct module_signature sig_info = {
> +		.id_type	= PKEY_ID_MERKLE,
> +		.sig_len	= htonl(sig_len),
> +	};
> +
> +	if (write(fd, &sig_info, sizeof(sig_info)) < 0)
> +		err(1, "write(sig_info) failed");
> +
> +	if (write(fd, &magic_number, sizeof(magic_number) - 1) < 0)
> +		err(1, "write(magic_number) failed");

Nit: Checking that the written size exactly matches the size of the
input data would be safer and consistent with other uses of write() in
write_be_int() and write_hash(). Additionally, it would be good to make
the error messages consistent in all cases.

> +}
> +
> +static void write_merkle_root(struct mtree *mt, const char *fp)
> +{
> +	char buf[1024];
> +	unsigned int levels;
> +	unsigned char *h;
> +	FILE *f;
> +
> +	if (mt) {
> +		levels = mt->levels;
> +		h = mt->l[mt->levels - 1][0].hash;
> +	} else {
> +		levels = 0;
> +		h = xcalloc(1, hash_size);
> +	}
> +
> +	f = fopen(fp, "w");
> +	if (!f)
> +		err(1, "Failed to create %s", buf);

The last parameter to err() should be fp. The buf variable is then
unused and can be removed.

> +
> +	fprintf(f, "#include <linux/module_hashes.h>\n\n");
> +	fprintf(f, "const struct module_hashes_root module_hashes_root __module_hashes_section = {\n");
> +
> +	fprintf(f, "\t.levels = %u,\n", levels);
> +	fprintf(f, "\t.hash = {");
> +	for (unsigned int i = 0; i < hash_size; i++) {
> +		char *space = "";
> +
> +		if (!(i % 8))
> +			fprintf(f, "\n\t\t");
> +
> +		if ((i + 1) % 8)
> +			space = " ";
> +
> +		fprintf(f, "0x%02x,%s", h[i], space);
> +	}
> +	fprintf(f, "\n\t},");
> +
> +	fprintf(f, "\n};\n");
> +	fclose(f);

Is it ok not to check the return values when writing to this output
file? Other code checks that its output was successful.

> +
> +	if (!mt)
> +		free(h);
> +}
> +
> +static char *xstrdup_replace_suffix(const char *str, const char *new_suffix)
> +{
> +	const char *current_suffix;
> +	size_t base_len;
> +
> +	current_suffix = strchr(str, '.');

It is safer to use strrchr() in case the module path happens to contain
a dot.

> +	if (!current_suffix)
> +		errx(1, "No existing suffix in '%s'", str);
> +
> +	base_len = current_suffix - str;
> +
> +	return xasprintf("%.*s%s", (int)base_len, str, new_suffix);
> +}
> +
> +static void read_modules_order(const char *fname, const char *suffix)
> +{
> +	char line[PATH_MAX];

<limits.h> should be included at the top to provide the definition of
PATH_MAX.

> +	FILE *in;
> +
> +	in = fopen(fname, "r");
> +	if (!in)
> +		err(1, "fopen(%s)", fname);

Nit: The error message could be "Failed to open %s" to maintain
consistency with a similar error in write_merkle_root().

> +
> +	while (fgets(line, PATH_MAX, in)) {
> +		struct file_entry *entry;
> +
> +		fh_list = xreallocarray(fh_list, num_files + 1, sizeof(*fh_list));

It might be useful to not reallocate this array for each file, although
I don't immediately see that it contributes any significant time to the
runtime.

> +		entry = &fh_list[num_files];
> +
> +		entry->pos = num_files;
> +		entry->name = xstrdup_replace_suffix(line, suffix);
> +		hash_file(entry);
> +
> +		num_files++;
> +	}
> +
> +	fclose(in);
> +}
> +
> +static __attribute__((noreturn))
> +void format(void)
> +{
> +	fprintf(stderr,
> +		"Usage: scripts/modules-merkle-tree <root definition>\n");

The usage string should mention the second parameter, which is the
module suffix.

> +	exit(2);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const EVP_MD *hash_evp;
> +	struct mtree *mt;
> +
> +	if (argc != 3)
> +		format();
> +
> +	hash_evp = EVP_get_digestbyname("sha256");
> +	ERR(!hash_evp, "EVP_get_digestbyname");
> +
> +	ctx = EVP_MD_CTX_new();
> +	ERR(!ctx, "EVP_MD_CTX_new()");
> +
> +	hash_size = EVP_MD_get_size(hash_evp);
> +	ERR(hash_size <= 0, "EVP_get_digestbyname");
> +
> +	if (EVP_DigestInit_ex(ctx, hash_evp, NULL) != 1)
> +		ERR(1, "EVP_DigestInit_ex()");
> +
> +	read_modules_order("modules.order", argv[2]);
> +
> +	mt = build_merkle(fh_list, num_files);
> +	write_merkle_root(mt, argv[1]);
> +	for (unsigned int i = 0; i < num_files; i++) {
> +		char *signame;
> +		int fd;
> +
> +		signame = xstrdup_replace_suffix(fh_list[i].name, ".merkle");
> +
> +		fd = open(signame, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +		if (fd < 0)
> +			err(1, "Can't create %s", signame);
> +
> +		build_proof(mt, i, fd);
> +		append_module_signature_magic(fd, lseek(fd, 0, SEEK_CUR));
> +		close(fd);

The return code of close() should be checked, otherwise it is
meaningless to check the write() calls in
append_module_signature_magic().

> +	}
> +
> +	free_mtree(mt);
> +	for (unsigned int i = 0; i < num_files; i++)
> +		free(fh_list[i].name);
> +	free(fh_list);
> +
> +	EVP_MD_CTX_free(ctx);
> +	return 0;
> +}

-- 
Thanks,
Petr

