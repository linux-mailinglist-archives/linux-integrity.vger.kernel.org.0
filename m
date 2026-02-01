Return-Path: <linux-integrity+bounces-8394-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDYQI8Z9f2klsAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8394-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 17:22:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984BC6746
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D60F030062F1
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A46264FBD;
	Sun,  1 Feb 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="bEfjssX6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC511261B8F;
	Sun,  1 Feb 2026 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962944; cv=none; b=WtrGi4yPv3bQaqLAL0d6U4yNWI+8xuiOgc/FeFhUABp/qVLVj5cxi31JtmhRwcxsy7j342RRCnLnin0UdnKTNAZUdXm5tpye82XTK+DbfCdHG5v8mMvu3PM4mtckwPxfIQlpk8eBjJV7aEGgg3SAfBri0TExBc/3kG8ngbTAzvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962944; c=relaxed/simple;
	bh=xlStmTRMhWVPt3fGtyXwEEDK5QLc9ZLigiHpsUvTOrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLHvyBQsrAQffTN7zZEXGg+NczdAqElK85oRg10p691IeqYUVqETZWC6gKQPCV0difis/p77bupvKeiE5n4V9jn4RARDzx3QFR6K4EIxgyqID9R6GHf/PBgzsUmN7gCYfgBEwCFe1189hNJk8jE0V98u12+Td13MKoYIzUv6JjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=bEfjssX6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1769962934;
	bh=xlStmTRMhWVPt3fGtyXwEEDK5QLc9ZLigiHpsUvTOrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEfjssX6nVvGGJYCjRv1Hgum2HvUXJPGA7CgYPlDg4pNFEnfuqh6BJNVd4xzoEnb/
	 ZMmAJGEOHpCghTNwc5ybR5xqiScFWUgOJvwITdq0n0q7Kv6pPqNjU99FoLxmpQ1ILY
	 /UCNvFIurX5sZ1rKb2ccqszu5PRz2lLOVB+DzJaQ=
Date: Sun, 1 Feb 2026 17:22:12 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mihai-Drosi =?utf-8?B?Q8OianU=?= <mcaju95@gmail.com>
Cc: arnd@arndb.de, arnout@bzzt.net, atomlin@atomlin.com, 
	bigeasy@linutronix.de, chleroy@kernel.org, christian@heusel.eu, corbet@lwn.net, 
	coxu@redhat.com, da.gomez@kernel.org, da.gomez@samsung.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, f.gruenbichler@proxmox.com, 
	jmorris@namei.org, kpcyrd@archlinux.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lkp@intel.com, 
	maddy@linux.ibm.com, mattia@mapreri.org, mcgrof@kernel.org, mpe@ellerman.id.au, 
	nathan@kernel.org, naveen@kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr, 
	nicolas.schier@linux.dev, npiggin@gmail.com, nsc@kernel.org, paul@paul-moore.com, 
	petr.pavlu@suse.com, roberto.sassu@huawei.com, samitolvanen@google.com, 
	serge@hallyn.com, xiujianfeng@huawei.com, zohar@linux.ibm.com
Subject: Re: [PATCH v4 00/17] module: Introduce hash-based integrity checking
Message-ID: <1ff0f085-fe89-48b4-bae3-559777a56a0d@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260131073636.65494-1-mcaju95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131073636.65494-1-mcaju95@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8394-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,bzzt.net,atomlin.com,linutronix.de,kernel.org,heusel.eu,lwn.net,redhat.com,samsung.com,gmail.com,oracle.com,proxmox.com,namei.org,archlinux.org,vger.kernel.org,lists.ozlabs.org,intel.com,linux.ibm.com,mapreri.org,ellerman.id.au,oss.cyber.gouv.fr,linux.dev,paul-moore.com,suse.com,huawei.com,google.com,hallyn.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4984BC6746
X-Rspamd-Action: no action

Hi Mihai-Drosi,

thanks for taking an interest into these patches!

On 2026-01-31 09:36:36+0200, Mihai-Drosi Câju wrote:
> > The current signature-based module integrity checking has some drawbacks
> > in combination with reproducible builds. Either the module signing key
> > is generated at build time, which makes the build unreproducible, or a
> > static signing key is used, which precludes rebuilds by third parties
> > and makes the whole build and packaging process much more complicated.
> 
> I think there is a middle ground where the module signing key is generated
> using a key derivation function that has as an input a deterministic value
> on the build host, such as /etc/machine-id . The problem with this approach
> is that only hosts knowing the value will be able to reproduce the build.

The goal is to make the distro kernel packages rebuildable by the
general public. Any involvement of secret values will break this goal.

> Maybe this is a solution to NixOS secret management? Introduce minimal
> impurity as a cryptographic seed and derive the rest of the secrets using
> something like Argon2(seed, key_uuid).

I am not familiar with NixOS and its secret management.
This patchset serves a wider audience.

> There might be another approach to code integrity rather than step-by-step
> reproducibility. One may exploit the very cryptographic primitives that make
> reproducibility hard to ensure that reproducibility is most  likely valid.
> 
> For example, the module signing issue, the build host publishes four artifacts:
> * The source-code
> * The compiled and signed binary
> * The build environment
> * Its public key
> 
> Now, we don't need to sign with the private key to know that building the source
> code using the specific build environment and signing the result with the private
> key will result in the claimed binary. We can just compile and verify with the
> public key.

This could work if the goal is only to verify the reproducibility of a
single, signed-en-bloc artifact. But we also need to handle vmlinux which
contains the corresponding public key. It would need different handling.
We can add some special logic to strip that public key before
comparision. But then vmlinux might be compressed or wrapped in some
other format. Another whole collection of special logic.

(...)


Thomas

