Return-Path: <linux-integrity+bounces-9782-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VPheF0w3KGpKAQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9782-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 17:54:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9DE66207F
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 17:54:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eXYsraaB;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9782-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9782-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64B5D301475D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2026 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38949218A;
	Tue,  9 Jun 2026 15:44:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4D43C06C;
	Tue,  9 Jun 2026 15:44:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019861; cv=none; b=sYEmjzTq3wCTZwMDN8ixFY9W8ToaQL74EWQ2pmjlurnRyAld8iZZPfXN5ApY7H6j4OcEEBLROQHXlYc4m2iVTF6mwF4/nN82iTW2GCl81r1HNHWLSx2+7UOgvkYjM8RsPuzs2J9fTSKy2GFVh2oZoHj3IeECuGRLbXQKMPAaF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019861; c=relaxed/simple;
	bh=+dAUjj6vNE3Mt200Mcrwkt02kuAG1stb/QoD0y/CywY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckW75gwbQU6+/ON6vA2udru0IHOBw8R6fzARxlfQKQ9Xcx7qx3l1wLrz8br+nDPLTQ24X9zbv2YI23deDoxubTbXeYmQcG86rZ8xeiluu5JzpYPnDYCYcfS26t26j0b3McPCNuen8vJ+gFeWN2IH6+TKyDzL4omcohKbixUFT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXYsraaB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 046FC1F00893;
	Tue,  9 Jun 2026 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019859;
	bh=ce8L9DISpwG1PJQJprZn1hYi7eQgp6fXvlvdL6UkEEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eXYsraaBQI6xIRRnyvAoBPsxOwFBxKoQiCFLppBLREP3vijfvXtA83w/mxmGr15h5
	 BprZwK55p5JKm/Ao1aWvcaJnl7qBIww8MWrh4qXxyOSAERHx1JvFOIJjQUpW49iFDY
	 a4yh0FYYGaUhTt4MXGhK69bQw238STV6P+KPVfU1vK3hFcNPcvZTcOcE0kbBQGeLWk
	 4BmiUbiAez+t6nUNbCqYFLXVVafyirojstjbo8PoS+F/FXyv02plVJ2BwmxV/4HHet
	 0GyrAEANN1n89tmvp6vapE9+4dvOBA7xVuMGGPumkeO6ExTE5CTnL6EWkno07Jujut
	 ehaf98HpJhPYg==
Date: Tue, 9 Jun 2026 18:44:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Benoit HOUYERE <benoit.houyere@st.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Jouen <fjouen@sealsq.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	Laurent CHARPENTIER <laurent.charpentier@st.com>
Subject: Re: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
Message-ID: <aig0zxWAvbrQuQnQ@kernel.org>
References: <20250918193019.4018706-1-jarkko@kernel.org>
 <aMzSyCQks3NlMhPI@mail.hallyn.com>
 <DB5PR10MB766844D5478D63272584A12AFE1C2@DB5PR10MB7668.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB5PR10MB766844D5478D63272584A12AFE1C2@DB5PR10MB7668.EURPRD10.PROD.OUTLOOK.COM>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9782-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:benoit.houyere@st.com,m:serge@hallyn.com,m:linux-integrity@vger.kernel.org,m:fjouen@sealsq.com,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:James.Bottomley@hansenpartnership.com,m:zohar@linux.ibm.com,m:dhowells@redhat.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:linux-kernel@vger.kernel.org,m:keyrings@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:laurent.charpentier@st.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[hallyn.com,vger.kernel.org,sealsq.com,gmx.de,ziepe.ca,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,sealsq.com:email,paul-moore.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA9DE66207F

On Mon, Jun 08, 2026 at 02:46:28PM +0000, Benoit HOUYERE wrote:
> Hello Serge and Jarkko,
> 
> 
> We have detected a regression with this fix. Indeed, it miss one zero on TPM_LONG_LONG. Initial value was 300000 and not 30000.
> 
> > +	{TPM2_CC_CREATE_PRIMARY, 30000},
> > +	{TPM2_CC_CREATE, 30000},
> > +	{TPM2_CC_CREATE_LOADED, 30000},
> 
> > +enum tpm2_durations {
> >  	TPM2_DURATION_SHORT     =     20,
> > -	TPM2_DURATION_MEDIUM    =    750,
> >  	TPM2_DURATION_LONG      =   2000,
> > -	TPM2_DURATION_LONG_LONG = 300000,
> >  	TPM2_DURATION_DEFAULT   = 120000,
> >  };
> 
> Best Regards,  Cordialement, Cordialmente, Hälsningar, 最好的问候, Mit besten Grüßen, 真心を込めて, 진심으로
> 
> 
> Benoit HOUYERE | Tel: +33 6 14 22 81 30
> TPM specialist

This has been fixed in 478a3f949a43822dc6ce089345ae80e8dcde3300.

> 
> -----Original Message-----
> From: Serge E. Hallyn <serge@hallyn.com> 
> Sent: Friday, September 19, 2025 5:49 AM
> To: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-integrity@vger.kernel.org; Frédéric Jouen <fjouen@sealsq.com>; Peter Huewe <peterhuewe@gmx.de>; Jason Gunthorpe <jgg@ziepe.ca>; James Bottomley <James.Bottomley@hansenpartnership.com>; Mimi Zohar <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; Paul Moore <paul@paul-moore.com>; James Morris <jmorris@namei.org>; Serge E. Hallyn <serge@hallyn.com>; open list <linux-kernel@vger.kernel.org>; open list:KEYS-TRUSTED <keyrings@vger.kernel.org>; open list:SECURITY SUBSYSTEM <linux-security-module@vger.kernel.org>
> Subject: Re: [PATCH v2] tpm: use a map for tpm2_calc_ordinal_duration()
> 
> On Thu, Sep 18, 2025 at 10:30:18PM +0300, Jarkko Sakkinen wrote:
> > The current shenanigans for duration calculation introduce too much 
> > complexity for a trivial problem, and further the code is hard to 
> > patch and maintain.
> > 
> > Address these issues with a flat look-up table, which is easy to 
> > understand and patch. If leaf driver specific patching is required in 
> > future, it is easy enough to make a copy of this table during driver 
> > initialization and add the chip parameter back.
> > 
> > 'chip->duration' is retained for TPM 1.x.
> > 
> > As the first entry for this new behavior address TCG spec update 
> > mentioned in this issue:
> > 
> > https://github.com/raspberrypi/linux/issues/7054
> > 
> > Therefore, for TPM_SelfTest the duration is set to 3000 ms.
> > 
> > This does not categorize a as bug, given that this is introduced to 
> > the spec after the feature was originally made.
> > 
> > Cc: Frédéric Jouen <fjouen@sealsq.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> fwiw (which shouldn't be much) looks good to me, but two questions, one here and one below.
> 
> First, it looks like in the existing code it is possible for a tpm2 chip to set its own timeouts and then set the TPM_CHIP_FLAG_HAVE_TIMEOUTS flag to avoid using the defaults, but I don't see anything using that in-tree.  Is it possible that there are out of tree drivers that will be sabotaged here?  Or am I misunderstanding that completely?
> 
> > ---
> > v2:
> > - Add the missing msec_to_jiffies() calls.
> > - Drop redundant stuff.
> > ---
> >  drivers/char/tpm/tpm-interface.c |   2 +-
> >  drivers/char/tpm/tpm.h           |   2 +-
> >  drivers/char/tpm/tpm2-cmd.c      | 127 ++++++++-----------------------
> >  include/linux/tpm.h              |   5 +-
> >  4 files changed, 37 insertions(+), 99 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c 
> > b/drivers/char/tpm/tpm-interface.c
> > index b71725827743..c9f173001d0e 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -52,7 +52,7 @@ MODULE_PARM_DESC(suspend_pcr,  unsigned long 
> > tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)  {
> >  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > -		return tpm2_calc_ordinal_duration(chip, ordinal);
> > +		return tpm2_calc_ordinal_duration(ordinal);
> >  	else
> >  		return tpm1_calc_ordinal_duration(chip, ordinal);  } diff --git 
> > a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h index 
> > 7bb87fa5f7a1..2726bd38e5ac 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -299,7 +299,7 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 
> > property_id,  ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip);  
> > int tpm2_auto_startup(struct tpm_chip *chip);  void 
> > tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type); -unsigned 
> > long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> > +unsigned long tpm2_calc_ordinal_duration(u32 ordinal);
> >  int tpm2_probe(struct tpm_chip *chip);  int 
> > tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);  int tpm2_find_cc(struct 
> > tpm_chip *chip, u32 cc); diff --git a/drivers/char/tpm/tpm2-cmd.c 
> > b/drivers/char/tpm/tpm2-cmd.c index 524d802ede26..7d77f6fbc152 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -28,120 +28,57 @@ static struct tpm2_hash tpm2_hash_map[] = {
> >  
> >  int tpm2_get_timeouts(struct tpm_chip *chip)  {
> > -	/* Fixed timeouts for TPM2 */
> >  	chip->timeout_a = msecs_to_jiffies(TPM2_TIMEOUT_A);
> >  	chip->timeout_b = msecs_to_jiffies(TPM2_TIMEOUT_B);
> >  	chip->timeout_c = msecs_to_jiffies(TPM2_TIMEOUT_C);
> >  	chip->timeout_d = msecs_to_jiffies(TPM2_TIMEOUT_D);
> > -
> > -	/* PTP spec timeouts */
> > -	chip->duration[TPM_SHORT] = msecs_to_jiffies(TPM2_DURATION_SHORT);
> > -	chip->duration[TPM_MEDIUM] = msecs_to_jiffies(TPM2_DURATION_MEDIUM);
> > -	chip->duration[TPM_LONG] = msecs_to_jiffies(TPM2_DURATION_LONG);
> > -
> > -	/* Key creation commands long timeouts */
> > -	chip->duration[TPM_LONG_LONG] =
> > -		msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
> > -
> >  	chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
> > -
> >  	return 0;
> >  }
> >  
> > -/**
> > - * tpm2_ordinal_duration_index() - returns an index to the chip 
> > duration table
> > - * @ordinal: TPM command ordinal.
> > - *
> > - * The function returns an index to the chip duration table
> > - * (enum tpm_duration), that describes the maximum amount of
> > - * time the chip could take to return the result for a  particular ordinal.
> > - *
> > - * The values of the MEDIUM, and LONG durations are taken
> > - * from the PC Client Profile (PTP) specification (750, 2000 msec)
> > - *
> > - * LONG_LONG is for commands that generates keys which empirically 
> > takes
> > - * a longer time on some systems.
> > - *
> > - * Return:
> > - * * TPM_MEDIUM
> > - * * TPM_LONG
> > - * * TPM_LONG_LONG
> > - * * TPM_UNDEFINED
> > +/*
> > + * Contains the maximum durations in milliseconds for TPM2 commands.
> >   */
> > -static u8 tpm2_ordinal_duration_index(u32 ordinal) -{
> > -	switch (ordinal) {
> > -	/* Startup */
> > -	case TPM2_CC_STARTUP:                 /* 144 */
> > -		return TPM_MEDIUM;
> > -
> > -	case TPM2_CC_SELF_TEST:               /* 143 */
> > -		return TPM_LONG;
> > -
> > -	case TPM2_CC_GET_RANDOM:              /* 17B */
> > -		return TPM_LONG;
> > -
> > -	case TPM2_CC_SEQUENCE_UPDATE:         /* 15C */
> > -		return TPM_MEDIUM;
> > -	case TPM2_CC_SEQUENCE_COMPLETE:       /* 13E */
> > -		return TPM_MEDIUM;
> > -	case TPM2_CC_EVENT_SEQUENCE_COMPLETE: /* 185 */
> > -		return TPM_MEDIUM;
> > -	case TPM2_CC_HASH_SEQUENCE_START:     /* 186 */
> > -		return TPM_MEDIUM;
> > -
> > -	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
> > -		return TPM_LONG_LONG;
> > -
> > -	case TPM2_CC_PCR_EXTEND:              /* 182 */
> > -		return TPM_MEDIUM;
> > -
> > -	case TPM2_CC_HIERARCHY_CONTROL:       /* 121 */
> > -		return TPM_LONG;
> > -	case TPM2_CC_HIERARCHY_CHANGE_AUTH:   /* 129 */
> > -		return TPM_LONG;
> > -
> > -	case TPM2_CC_GET_CAPABILITY:          /* 17A */
> > -		return TPM_MEDIUM;
> > -
> > -	case TPM2_CC_NV_READ:                 /* 14E */
> > -		return TPM_LONG;
> > -
> > -	case TPM2_CC_CREATE_PRIMARY:          /* 131 */
> > -		return TPM_LONG_LONG;
> > -	case TPM2_CC_CREATE:                  /* 153 */
> > -		return TPM_LONG_LONG;
> > -	case TPM2_CC_CREATE_LOADED:           /* 191 */
> > -		return TPM_LONG_LONG;
> > -
> > -	default:
> > -		return TPM_UNDEFINED;
> > -	}
> > -}
> > +static const struct {
> > +	unsigned long ordinal;
> > +	unsigned long duration;
> > +} tpm2_ordinal_duration_map[] = {
> > +	{TPM2_CC_STARTUP, 750},
> > +	{TPM2_CC_SELF_TEST, 3000},
> 
> I assume you intended to increase TPM2_CC_SELF_TEST from 2000 to 3000 here?  But it's not mentioned in the commit, so making sure...
> 
> > +	{TPM2_CC_GET_RANDOM, 2000},
> > +	{TPM2_CC_SEQUENCE_UPDATE, 750},
> > +	{TPM2_CC_SEQUENCE_COMPLETE, 750},
> > +	{TPM2_CC_EVENT_SEQUENCE_COMPLETE, 750},
> > +	{TPM2_CC_HASH_SEQUENCE_START, 750},
> > +	{TPM2_CC_VERIFY_SIGNATURE, 30000},
> > +	{TPM2_CC_PCR_EXTEND, 750},
> > +	{TPM2_CC_HIERARCHY_CONTROL, 2000},
> > +	{TPM2_CC_HIERARCHY_CHANGE_AUTH, 2000},
> > +	{TPM2_CC_GET_CAPABILITY, 750},
> > +	{TPM2_CC_NV_READ, 2000},
> > +	{TPM2_CC_CREATE_PRIMARY, 30000},
> > +	{TPM2_CC_CREATE, 30000},
> > +	{TPM2_CC_CREATE_LOADED, 30000},
> > +};
> >  
> >  /**
> > - * tpm2_calc_ordinal_duration() - calculate the maximum command duration
> > - * @chip:    TPM chip to use.
> > + * tpm2_calc_ordinal_duration() - Calculate the maximum command 
> > + duration
> >   * @ordinal: TPM command ordinal.
> >   *
> > - * The function returns the maximum amount of time the chip could 
> > take
> > - * to return the result for a particular ordinal in jiffies.
> > - *
> > - * Return: A maximal duration time for an ordinal in jiffies.
> > + * Returns the maximum amount of time the chip is expected by kernel 
> > + to
> > + * take in jiffies.
> >   */
> > -unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 
> > ordinal)
> > +unsigned long tpm2_calc_ordinal_duration(u32 ordinal)
> >  {
> > -	unsigned int index;
> > +	int i;
> >  
> > -	index = tpm2_ordinal_duration_index(ordinal);
> > +	for (i = 0; i < ARRAY_SIZE(tpm2_ordinal_duration_map); i++)
> > +		if (ordinal == tpm2_ordinal_duration_map[i].ordinal)
> > +			return msecs_to_jiffies(tpm2_ordinal_duration_map[i].duration);
> >  
> > -	if (index != TPM_UNDEFINED)
> > -		return chip->duration[index];
> > -	else
> > -		return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> > +	return msecs_to_jiffies(TPM2_DURATION_DEFAULT);
> >  }
> >  
> > -
> >  struct tpm2_pcr_read_out {
> >  	__be32	update_cnt;
> >  	__be32	pcr_selects_cnt;
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h index 
> > b0e9eb5ef022..dc0338a783f3 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -228,10 +228,11 @@ enum tpm2_timeouts {
> >  	TPM2_TIMEOUT_B          =   4000,
> >  	TPM2_TIMEOUT_C          =    200,
> >  	TPM2_TIMEOUT_D          =     30,
> > +};
> > +
> > +enum tpm2_durations {
> >  	TPM2_DURATION_SHORT     =     20,
> > -	TPM2_DURATION_MEDIUM    =    750,
> >  	TPM2_DURATION_LONG      =   2000,
> > -	TPM2_DURATION_LONG_LONG = 300000,
> >  	TPM2_DURATION_DEFAULT   = 120000,
> >  };
> >  
> > --
> > 2.39.5
> 

BR, Jarkko

