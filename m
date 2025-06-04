Return-Path: <linux-integrity+bounces-6361-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021F5ACE259
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D745A7A79F7
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Jun 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1991E32B9;
	Wed,  4 Jun 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIgnawx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UQ1Fgfvm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EIgnawx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UQ1Fgfvm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B031DB546
	for <linux-integrity@vger.kernel.org>; Wed,  4 Jun 2025 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055286; cv=none; b=PrAzT6RWRC7VlkhNJCDqafffEF4oICdtxC8fiPSjOxWhW1a5Uq8Kr2QELPSQzwBJ2AQSVnpc8awZvsGyQifycYwPrkl57VatOIltGQUNM+xymifcKvioSVF2VEJnCMdvOWeKNT4Ne2roxWwSykJuzNtjqEa20irpwpRpfXvqpJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055286; c=relaxed/simple;
	bh=C9rm+XJZJ0kW9eOg3VwjO1wOGy0L3PX6/Zc32yEI4LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTxnt20eeEoy05NRZ/wqndIBbP5kA/d7/Q1PetVklQhfdnUkcU2kDSJiC4SiECmSfOvIPokzuLD2x057nKBbosGMpMVEsmMlYxmh+FpBY+3C5iWE2Bzd369fqyoolMJmM4NJ+33teWA0I7+uyh6fbGZrKzk1TrTeqyaIUNFeoGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EIgnawx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UQ1Fgfvm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EIgnawx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UQ1Fgfvm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D29D20209;
	Wed,  4 Jun 2025 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749055281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0egcYhcf51j/LkwCnpKG56NS3g4NQU4yYCzICMwTCgg=;
	b=EIgnawx2HdMThsgyIJTmhuAupLMZsQV2hpSmN8+0vIcjkFS+sEX/wVBd/yQTM9nx5q6Cjl
	mjC3YPfSJyh6BUNTSNZgBEBhKfNRGOX07PhVuc83T9ow+oINElJQ9+mwJMajWSv4F4sXdZ
	x4jigFchjBMHOBMaFZqjOV3AucYoJYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749055281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0egcYhcf51j/LkwCnpKG56NS3g4NQU4yYCzICMwTCgg=;
	b=UQ1Fgfvmbzl2TK9I3IIA/dGIvUjazWn+4niLAhZ7JSAPh/POMnL7L4Ob0ovDX27ctzdNIX
	iSkkLJPVBdWXf8DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749055281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0egcYhcf51j/LkwCnpKG56NS3g4NQU4yYCzICMwTCgg=;
	b=EIgnawx2HdMThsgyIJTmhuAupLMZsQV2hpSmN8+0vIcjkFS+sEX/wVBd/yQTM9nx5q6Cjl
	mjC3YPfSJyh6BUNTSNZgBEBhKfNRGOX07PhVuc83T9ow+oINElJQ9+mwJMajWSv4F4sXdZ
	x4jigFchjBMHOBMaFZqjOV3AucYoJYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749055281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0egcYhcf51j/LkwCnpKG56NS3g4NQU4yYCzICMwTCgg=;
	b=UQ1Fgfvmbzl2TK9I3IIA/dGIvUjazWn+4niLAhZ7JSAPh/POMnL7L4Ob0ovDX27ctzdNIX
	iSkkLJPVBdWXf8DA==
Date: Wed, 4 Jun 2025 18:41:20 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
	zohar@linux.ibm.com, nayna@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] powerpc/secvar: Expose secvars relevant to the
 key management mode
Message-ID: <aEB3MPAYeAaFVpTc@kitsune.suse.cz>
References: <20250521105759.8408-1-ssrish@linux.ibm.com>
 <20250521105759.8408-3-ssrish@linux.ibm.com>
 <aDATahmPIsOmiFAK@kitsune.suse.cz>
 <7dcd0f77-852b-4f4c-9842-f1d96e1d8b65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dcd0f77-852b-4f4c-9842-f1d96e1d8b65@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,csgroup.eu,kernel.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Thu, May 29, 2025 at 10:39:58PM +0530, Srish Srinivasan wrote:
> 
> On 5/23/25 11:49 AM, Michal Suchánek wrote:
> > Hello,
> > 
> > On Wed, May 21, 2025 at 04:27:58PM +0530, Srish Srinivasan wrote:
> > > The PLPKS enabled PowerVM LPAR sysfs exposes all of the secure boot
> > > secvars irrespective of the key management mode.
> > > 
> > > The PowerVM LPAR supports static and dynamic key management for secure
> > > boot. The key management option can be updated in the management
> > > console. Only in the dynamic key mode can the user modify the secure
> > > boot secvars db, dbx, grubdb, grubdbx, and sbat, which are exposed via
> > > the sysfs interface. But the sysfs interface exposes these secvars even
> > > in the static key mode. This could lead to errors when reading them or
> > > writing to them in the static key mode.
> > would it cause an error when reading these variables or only when
> > writing them?
> > 
> > Thanks
> > 
> > Michal
> 
> Hi Michal,
> Thanks for taking a look.
> 
> 
> Yes, when PKS is enabled without enabling dynamic key secure boot, the
> secvars
> are NOT yet initialized with the default keys built into the binaries, and
> therefore
> reading them will result in an error.

That suggests that 'cannot be written' as said in the documentation and
commit message, which would imply readonly, is misleading. The value is
not accessible at all.

> Now, while in static key management mode with PKS enabled, if one tries to
> populate secvars that are relevant to dynamic key management, the write does
> not fail as long as the "Platform KeyStore Signed Update Infrastructure"
> flag on
> the HMC is enabled and the signed updates are authorized by valid PK/KEK
> keys.

Which suggests that some variables can if fact be written

> However, secvars like db and grubdb populated while in static key management
> mode are not used by the Partition Firmware or grub as SB_VERSION is not
> present,

but are not used until the key management is switched to dynamic

> i.e dynamic key secure boot has not been enabled yet. In this case, when
> there is a
> transition from static key management to dynamic key management, secvars
> with
> the signed update policy bit set will not be overwritten by the hypervisor
> with the
> default keys. Now, if the keys written into these secvars were not the ones
> that were
> used to sign the grub and kernel, it would fail to verify them.

Which is the case even for the case the system is already in dynamic key
mode, unless the variables are append-only.

Thanks

Michal

> These are the reasons behind the decision to expose only those secvars that
> are
> relevant to the key management mode.
> 
> > 
> > 
> > > Expose only PK, trustedcadb, and moduledb in the static key mode to
> > > enable loading of signed third-party kernel modules.
> > > 
> > > Co-developed-by: Souradeep <soura@imap.linux.ibm.com>
> > > Signed-off-by: Souradeep <soura@imap.linux.ibm.com>
> > > Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
> > > Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> > > ---
> > >   Documentation/ABI/testing/sysfs-secvar        |  6 ++++
> > >   arch/powerpc/platforms/pseries/plpks-secvar.c | 28 ++++++++++++++++---
> > >   2 files changed, 30 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-secvar b/Documentation/ABI/testing/sysfs-secvar
> > > index 45281888e520..948df3446a03 100644
> > > --- a/Documentation/ABI/testing/sysfs-secvar
> > > +++ b/Documentation/ABI/testing/sysfs-secvar
> > > @@ -37,6 +37,12 @@ Description:	Each secure variable is represented as a directory named as
> > >   		representation. The data and size can be determined by reading
> > >   		their respective attribute files.
> > > +		Only secvars relevant to the key management mode are exposed.
> > > +		Only in the dynamic key mode can the user modify the secure boot
> > > +		secvars db, dbx, grubdb, grubdbx, and sbat. PK, trustedcadb and
> > > +		moduledb are the secvars common to both static and dynamic key
> > > +		management modes.
> > > +
> > >   What:		/sys/firmware/secvar/vars/<variable_name>/size
> > >   Date:		August 2019
> > >   Contact:	Nayna Jain <nayna@linux.ibm.com>
> > > diff --git a/arch/powerpc/platforms/pseries/plpks-secvar.c b/arch/powerpc/platforms/pseries/plpks-secvar.c
> > > index 767e5e8c6990..f9e9cc40c9d0 100644
> > > --- a/arch/powerpc/platforms/pseries/plpks-secvar.c
> > > +++ b/arch/powerpc/platforms/pseries/plpks-secvar.c
> > > @@ -59,7 +59,14 @@ static u32 get_policy(const char *name)
> > >   		return PLPKS_SIGNEDUPDATE;
> > >   }
> > > -static const char * const plpks_var_names[] = {
> > > +static const char * const plpks_var_names_static[] = {
> > > +	"PK",
> > > +	"moduledb",
> > > +	"trustedcadb",
> > > +	NULL,
> > > +};
> > > +
> > > +static const char * const plpks_var_names_dynamic[] = {
> > >   	"PK",
> > >   	"KEK",
> > >   	"db",
> > > @@ -213,21 +220,34 @@ static int plpks_max_size(u64 *max_size)
> > >   	return 0;
> > >   }
> > > +static const struct secvar_operations plpks_secvar_ops_static = {
> > > +	.get = plpks_get_variable,
> > > +	.set = plpks_set_variable,
> > > +	.format = plpks_secvar_format,
> > > +	.max_size = plpks_max_size,
> > > +	.config_attrs = config_attrs,
> > > +	.var_names = plpks_var_names_static,
> > > +};
> > > -static const struct secvar_operations plpks_secvar_ops = {
> > > +static const struct secvar_operations plpks_secvar_ops_dynamic = {
> > >   	.get = plpks_get_variable,
> > >   	.set = plpks_set_variable,
> > >   	.format = plpks_secvar_format,
> > >   	.max_size = plpks_max_size,
> > >   	.config_attrs = config_attrs,
> > > -	.var_names = plpks_var_names,
> > > +	.var_names = plpks_var_names_dynamic,
> > >   };
> > >   static int plpks_secvar_init(void)
> > >   {
> > > +	u8 mode;
> > > +
> > >   	if (!plpks_is_available())
> > >   		return -ENODEV;
> > > -	return set_secvar_ops(&plpks_secvar_ops);
> > > +	mode = plpks_get_sb_keymgmt_mode();
> > > +	if (mode)
> > > +		return set_secvar_ops(&plpks_secvar_ops_dynamic);
> > > +	return set_secvar_ops(&plpks_secvar_ops_static);
> > >   }
> > >   machine_device_initcall(pseries, plpks_secvar_init);
> > > -- 
> > > 2.47.1
> > > 
> > > 
> 

