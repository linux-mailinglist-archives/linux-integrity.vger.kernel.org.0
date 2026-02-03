Return-Path: <linux-integrity+bounces-8423-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJixE1ftgWkFMAMAu9opvQ
	(envelope-from <linux-integrity+bounces-8423-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:43:03 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3CCD9279
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 13:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71BE4303787C
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A1D345752;
	Tue,  3 Feb 2026 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="VaAFHhJc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48055314D16;
	Tue,  3 Feb 2026 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122550; cv=none; b=ASRDJD/MYttH1q/HKz6CWyf9We/aIqkeR/pX5bO6jFa/JzGhUJrz7l7FvZEyU018M76/FBccghetz1dibvJ6lW7VDHCCtz+dley2r+XRxniemHdQAQ8lrqOuqcppV7sMOokMvbJYPp1YY732pFZEaH5e1YRFTEsiy+LUt1wtqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122550; c=relaxed/simple;
	bh=+vKlgAoMgxorO8wzZsSKLOlHjUax16wakp+NL76Z0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/5GoRGfw43sWg3wB4lWOYrvm/Eu2ta/2VMYF5DY7rFvEmcP+01MVFXhF4E0UzuEaTL5jZ30sVqRFSH1MqFTrJdZo2AA8KWRZ37kW08OZ4tB722qqX8LNapmTXCSxWMP6BNxgJVMHBZki4So46tE0JcwVzGOFvDysB8h7Ahqcx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=VaAFHhJc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1770122547;
	bh=+vKlgAoMgxorO8wzZsSKLOlHjUax16wakp+NL76Z0jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaAFHhJc7RJThp3X+a8KljdNfBU40Qohg4ZbBihrSHkldtnS2mr7PIOYLFNNVh3m4
	 iwPDIMK7zHXuYYbgAnk2nZqfMp/Kc/PcVHebE1k/b71FBy78nAPYLadtFkiaM5Sf6e
	 bpmVJeSOu/HMoajP8WRx2JjXQW/CSQtzckT5P31U=
Date: Tue, 3 Feb 2026 13:42:26 +0100
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
Subject: Re: [PATCH v4 12/17] module: Move signature splitting up
Message-ID: <2d6b4a2e-b65a-4db2-aa92-2ad80d066516@t-8ch.de>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
 <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa92ce4a-d336-4d03-b87d-1c39b1c553da@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8423-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t-8ch.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC3CCD9279
X-Rspamd-Action: no action

On 2026-01-29 15:41:43+0100, Petr Pavlu wrote:
> On 1/13/26 1:28 PM, Thomas Weißschuh wrote:
> > The signature splitting will also be used by CONFIG_MODULE_HASHES.
> > 
> > Move it up the callchain, so the result can be reused.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > [...]
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index c09b25c0166a..d65bc300a78c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
> >  
> >  static int module_integrity_check(struct load_info *info, int flags)
> >  {
> > +	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> > +				       MODULE_INIT_IGNORE_VERMAGIC);
> > +	size_t sig_len;
> > +	const u8 *sig;
> >  	int err = 0;
> >  
> > +	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> > +		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> > +				    &sig_len, &sig, "module");
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	if (IS_ENABLED(CONFIG_MODULE_SIG))
> > -		err = module_sig_check(info, flags);
> > +		err = module_sig_check(info, sig, sig_len);
> >  
> >  	if (err)
> >  		return err;
> 
> I suggest moving the IS_ENABLED(CONFIG_MODULE_SIG) block under the
> new IS_ENABLED(CONFIG_MODULE_SIG_POLICY) section. I realize that
> CONFIG_MODULE_SIG implies CONFIG_MODULE_SIG_POLICY, but I believe this
> change makes it more apparent that this it the case. Otherwise, one
> might for example wonder if sig_len in the module_sig_check() call can
> be undefined.
> 
> 	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
> 		err = mod_split_sig(info->hdr, &info->len, mangled_module,
> 				    &sig_len, &sig, "module");
> 		if (err)
> 			return err;
> 
> 		if (IS_ENABLED(CONFIG_MODULE_SIG))
> 			err = module_sig_check(info, sig, sig_len);
> 	}

Ack.

