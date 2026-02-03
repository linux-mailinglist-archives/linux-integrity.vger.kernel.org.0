Return-Path: <linux-integrity+bounces-8422-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK1xM+/tgWkFMAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8422-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:45:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 760FCD93B1
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DAA8300E390
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 12:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2243431F8;
	Tue,  3 Feb 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CkgRgfaM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1932E690;
	Tue,  3 Feb 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122486; cv=none; b=Rs9h8DpXWgfhaYRxnKDtCb7aKRJHQvO+qHKDX65ODADJdDGsdNPR5O9YzDJlwKDnZUZtAM+WMZFICRBkjkr2YjsEYIOcuZG8QfYWv25K7l/ld3/BmDfYjLysmeGx9USHo5KIky4uBkO5ELydkiAm397o/ghYVZ2aygDNqiN3zPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122486; c=relaxed/simple;
	bh=27oXttc/YCfqQLF6/9YmAKAGfCgRZ7XRUWdootutwwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOZR4xdjH+fB/N4VfNdrb+D2RxvRR0zz+s9kkzkmil6ZYXnZDGEvXJw4mQd5EBwRLZv+0QwxuWKgf28agCqfg8FA+JPGPrYeY6UNsvRDWUXGa0a8c0Bc4zXq9WA1qjRiDJxYathPyFVER7WwyN32cSE3wYpO6F2wYnMdM23P1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CkgRgfaM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770122475;
	bh=27oXttc/YCfqQLF6/9YmAKAGfCgRZ7XRUWdootutwwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkgRgfaM7qWLKghTEIx+MJoJL1TSz/puDFT4aA0A47zHSz7qBO38AmiuXDIbwnO+9
	 jTsm6rRQlV+UI6ps6KvSgRNlGU11st7vBubPuf2xiTrBSvQnmeeWfcacfFSVUoIDIM
	 58ywalIbcSvDlTUECIKiDn7Rl75oBHolY69QDVA4=
Date: Tue, 3 Feb 2026 13:41:14 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>, 
	Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, Arnout Engelen <arnout@bzzt.net>, 
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>, 
	Christian Heusel <christian@heusel.eu>, =?utf-8?B?Q8OianU=?= Mihai-Drosi <mcaju95@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 08/17] module: Deduplicate signature extraction
Message-ID: <df277beb-3bc2-4941-941e-adb294d34394@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-8-0b932db9b56b@weissschuh.net>
 <52cbbccf-d5b6-4a33-b16a-4a09fe5e64d3@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52cbbccf-d5b6-4a33-b16a-4a09fe5e64d3@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8422-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,google.com,samsung.com,paul-moore.com,namei.org,hallyn.com,lwn.net,linux.ibm.com,ellerman.id.au,gmail.com,huawei.com,oracle.com,linux.dev,atomlin.com,oss.cyber.gouv.fr,proxmox.com,bzzt.net,mapreri.org,archlinux.org,heusel.eu,linutronix.de,vger.kernel.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t-8ch.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,weissschuh.net:dkim]
X-Rspamd-Queue-Id: 760FCD93B1
X-Rspamd-Action: no action

On 2026-01-27 16:20:15+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:

(...)

> >  int module_sig_check(struct load_info *info, int flags)
> >  {
> > -	int err = -ENODATA;
> > -	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> > +	int err;
> >  	const char *reason;
> >  	const void *mod = info->hdr;
> > +	size_t sig_len;
> > +	const u8 *sig;
> >  	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> >  				       MODULE_INIT_IGNORE_VERMAGIC);
> > -	/*
> > -	 * Do not allow mangled modules as a module with version information
> > -	 * removed is no longer the module that was signed.
> > -	 */
> > -	if (!mangled_module &&
> > -	    info->len > markerlen &&
> > -	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
> > -		/* We truncate the module to discard the signature */
> > -		info->len -= markerlen;
> > -		err = mod_verify_sig(mod, info);
> > +
> > +	err = mod_split_sig(info->hdr, &info->len, mangled_module, &sig_len, &sig, "module");
> > +	if (!err) {
> > +		err = verify_pkcs7_signature(mod, info->len, sig, sig_len,
> > +					     VERIFY_USE_SECONDARY_KEYRING,
> > +					     VERIFYING_MODULE_SIGNATURE,
> > +					     NULL, NULL);
> >  		if (!err) {
> >  			info->sig_ok = true;
> >  			return 0;
> 
> The patch looks to modify the behavior when mangled_module is true.
> 
> Previously, module_sig_check() didn't attempt to extract the signature
> in such a case and treated the module as unsigned. The err remained set
> to -ENODATA and the function subsequently consulted module_sig_check()
> and security_locked_down() to determine an appropriate result.
> 
> Newly, module_sig_check() calls mod_split_sig(), which skips the
> extraction of the marker ("~Module signature appended~\n") from the end
> of the module and instead attempts to read it as an actual
> module_signature. The value is then passed to mod_check_sig() which
> should return -EBADMSG. The error is propagated to module_sig_check()
> and treated as fatal, without consulting module_sig_check() and
> security_locked_down().
> 
> I think the mangled_module flag should not be passed to mod_split_sig()
> and it should be handled solely by module_sig_check().

Ack.

(...)

> > diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
> > index 3265d744d5ce..a57342d39b07 100644
> > --- a/security/integrity/ima/ima_modsig.c
> > +++ b/security/integrity/ima/ima_modsig.c
> > @@ -40,44 +40,30 @@ struct modsig {
> >  int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
> >  		    struct modsig **modsig)
> >  {
> > -	const size_t marker_len = strlen(MODULE_SIG_STRING);
> > -	const struct module_signature *sig;
> > +	size_t buf_len_sz = buf_len;
> >  	struct modsig *hdr;
> >  	size_t sig_len;
> > -	const void *p;
> > +	const u8 *sig;
> >  	int rc;
> >  
> > -	if (buf_len <= marker_len + sizeof(*sig))
> > -		return -ENOENT;
> > -
> > -	p = buf + buf_len - marker_len;
> > -	if (memcmp(p, MODULE_SIG_STRING, marker_len))
> > -		return -ENOENT;
> > -
> > -	buf_len -= marker_len;
> > -	sig = (const struct module_signature *)(p - sizeof(*sig));
> > -
> > -	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
> > +	rc = mod_split_sig(buf, &buf_len_sz, true, &sig_len, &sig, func_tokens[func]);
> 
> Passing mangled=true to mod_split_sig() seems incorrect here. It causes
> that the function doesn't properly extract the signature marker at the
> end of the module, no?

Indeed, thanks.
 
I am thinking about dropping this patch from the series for now.
It was meant for IMA modsig compatibility, which is not part of the
series anymore.

> >  	if (rc)
> >  		return rc;
> >  
> > -	sig_len = be32_to_cpu(sig->sig_len);
> > -	buf_len -= sig_len + sizeof(*sig);
> > -
> >  	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
> >  	hdr = kzalloc(struct_size(hdr, raw_pkcs7, sig_len), GFP_KERNEL);
> >  	if (!hdr)
> >  		return -ENOMEM;
> >  
> >  	hdr->raw_pkcs7_len = sig_len;
> > -	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
> > +	hdr->pkcs7_msg = pkcs7_parse_message(sig, sig_len);
> >  	if (IS_ERR(hdr->pkcs7_msg)) {
> >  		rc = PTR_ERR(hdr->pkcs7_msg);
> >  		kfree(hdr);
> >  		return rc;
> >  	}
> >  
> > -	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
> > +	memcpy(hdr->raw_pkcs7, sig, sig_len);
> >  
> >  	/* We don't know the hash algorithm yet. */
> >  	hdr->hash_algo = HASH_ALGO__LAST;
> > 

