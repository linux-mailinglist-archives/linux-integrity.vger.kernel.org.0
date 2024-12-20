Return-Path: <linux-integrity+bounces-4447-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CD59F8FF8
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2024 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D97A188CC07
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8FE134AB;
	Fri, 20 Dec 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lYMbBN86";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fotjMg+U";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wnUi5/On";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KAfUdT9Z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E59E1BD9FA;
	Fri, 20 Dec 2024 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689731; cv=none; b=br2F97+IT140vjq6yw27ZU8q8VE/GXsWK3YRakh9XHWBT55U52CnfMxBAhBNHrFheMuKGJJX5Dcm5AiLz5VtjcQ1hyLdF3WkuE1U5mJaxA/qMcF2xaSC0RZ/BBLFG5aTghpRP/u7rEy7HAPOCEcsqOQfWhw7f0eT7AD9cKSgFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689731; c=relaxed/simple;
	bh=1pgVgX0KFc15PvmgsvJAFkJYvnHbqnFzeK1mErkruDI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlwK+pQsDs5bzG8WHWG2qZr60E8TV8jviPpYzUl6BYjeQupZRNfKsbVRwQdaHVvhT9R4v3NbjWyVOIry5eCoCz8pHqeaGXh+zuFdreMGNOfdUcOYlB/dz68Wkk3Tyj0y5Z6A8iE2tmsZTu8gz84Wm+GbNK4HjBa+YTrayaSzlnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lYMbBN86; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fotjMg+U; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wnUi5/On; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KAfUdT9Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEC2B21106;
	Fri, 20 Dec 2024 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734689726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/PKdWyNV1nkxgF4eNWxv+l6FqDqrtTMVBmffVdQ29k=;
	b=lYMbBN86Ncnc2k3336/4RoB9tNl6dqTRotKnvXIUvY6AsGz0gnApTyKFfN7mZg0RJ9WOh3
	noFbl+rKRXH9kLpcux6bO2Wr6VEjXO/IymMfHm0PWOTz8pDxlaBIRuwKEybTQQ+xutSDR+
	Iuk6jQmvtXnYQlj3VS6DtAdmJADDCPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734689726;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/PKdWyNV1nkxgF4eNWxv+l6FqDqrtTMVBmffVdQ29k=;
	b=fotjMg+UEKGHfXdILBWTQvH7UG5mrMu8T6XMcNaI3xms8efezfAhhzPg45175160T1XoVQ
	svPcv1K0FJXk4TDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wnUi5/On";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KAfUdT9Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734689725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/PKdWyNV1nkxgF4eNWxv+l6FqDqrtTMVBmffVdQ29k=;
	b=wnUi5/OnjIZ/C8S1lLtMMOMmLoEkMFQACSIyyhU3yReCuyRY1UZR8wezaMtzdw86Zr8hj0
	jlBPn3Y8saXYD4IKlOJKyjCxSisrowtMJ9lAKPJs1niPmsLJLsJpTKB7d8dFJobKOVySS3
	4MdWupIke1HtsjDFar3BksxBRZfTs4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734689725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8/PKdWyNV1nkxgF4eNWxv+l6FqDqrtTMVBmffVdQ29k=;
	b=KAfUdT9ZZQhWMWBplXRCi6DVqoBEiCUwyunavDrDtHHkxJV9TjsGMbyd8NpZro3dTeW9xd
	kQfnGSzR8Avm3UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7449B13A63;
	Fri, 20 Dec 2024 10:15:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id h5neGL1DZWdnAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 20 Dec 2024 10:15:25 +0000
Date: Fri, 20 Dec 2024 11:15:24 +0100
Message-ID: <87wmfuu0cj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Stefan Berger"
 <stefanb@linux.ibm.com>,
	<linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Andy Liang" <andy.liang@hpe.com>,
	"Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] tpm/eventlog: Limit memory allocations for event logs with excessive size
In-Reply-To: <D6FSFOOBPMHF.3UIDISOAITD3K@kernel.org>
References: <20241210222608.598424-1-stefanb@linux.ibm.com>
	<D6B49LBSZXN4.3V519030X0YCG@kernel.org>
	<709d3abb-d94d-44fc-a730-054139b13188@linux.ibm.com>
	<D6FS8ALS4HSV.2CSS6SGE8ND09@kernel.org>
	<D6FSFOOBPMHF.3UIDISOAITD3K@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: EEC2B21106
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 19 Dec 2024 16:38:40 +0100,
Jarkko Sakkinen wrote:
> 
> On Thu Dec 19, 2024 at 5:29 PM EET, Jarkko Sakkinen wrote:
> > On Mon Dec 16, 2024 at 9:29 PM EET, Stefan Berger wrote:
> > >
> > >
> > > On 12/13/24 10:51 PM, Jarkko Sakkinen wrote:
> > > > On Wed Dec 11, 2024 at 12:26 AM EET, Stefan Berger wrote:
> > > >> The TPM2 ACPI BIOS eventlog of a particular machine indicates that the
> > > >> length of the log is 4MB, even though the actual length of its useful data,
> > > >> when dumped, are only 69kb. To avoid allocating excessive amounts of memory
> > > >> for the event log, limit the size of any eventlog to 128kb. This should be
> > > >> sufficient memory and also not unnecessarily truncate event logs on any
> > > >> other machine.
> > > >>
> > > >> Reported-by: Andy Liang <andy.liang@hpe.com>
> > > >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
> > > >> Cc: Takashi Iwai <tiwai@suse.de>
> > > >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > >> ---
> > > >>   drivers/char/tpm/eventlog/acpi.c | 8 ++++++++
> > > >>   1 file changed, 8 insertions(+)
> > > >>
> > > >> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
> > > >> index 69533d0bfb51..701fd7d4cc28 100644
> > > >> --- a/drivers/char/tpm/eventlog/acpi.c
> > > >> +++ b/drivers/char/tpm/eventlog/acpi.c
> > > >> @@ -26,6 +26,8 @@
> > > >>   #include "../tpm.h"
> > > >>   #include "common.h"
> > > >>   
> > > >> +#define MAX_TPM_LOG_LEN		(128 * 1024)
> > > > 
> > > > Instead, to common.h:
> > > > 
> > > > /*
> > > >   * Cap the log size to the given number of bytes. Applied to the TPM2
> > > >   * ACPI logs.
> > > >   */
> > > > #define TPM_MAX_LOG_SIZE (128 * 1024)
> > >
> > > Done.
> > >
> > > > 
> > > >>
> > q >> +
> > > >>   struct acpi_tcpa {
> > > >>   	struct acpi_table_header hdr;
> > > >>   	u16 platform_class;
> > > >> @@ -135,6 +137,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> > > >>   		return -EIO;
> > > >>   	}
> > > >>   
> > > >> +	if (len > MAX_TPM_LOG_LEN) {
> > > >> +		dev_warn(&chip->dev, "Excessive TCPA log len %llu truncated to %u bytes\n",
> > > >> +			 len, MAX_TPM_LOG_LEN);
> > > >> +		len = MAX_TPM_LOG_LEN;
> > > >> +	}
> > > > 
> > > > First, you are changing also TPM1 code path. Also in the case of
> > >
> > > Ok, let's move it into the TPM2 code path then.
> > >
> > > > TPM2 code path the log message is incorrect as TCPA does not exist.
> > > > 
> > > > Second, this does not make sense as the log ends up to be corrupted
> > > > (i.e. not complete).
> > >
> > > Truncating the log is something I am trying to prevent by giving it a 
> > > generous size of 128 kb:
> > > "To avoid allocating excessive amounts of memory
> > > for the event log, limit the size of any eventlog to 128kb. This should be
> > > sufficient memory and also not unnecessarily truncate event logs on any
> > > other machine."
> > >
> > > The 8MB the machine with the faulty BIOS indicates are holding 69kb of 
> > > log data at the beginning and then unnecessary data after that. So 
> > > truncating this one to 128kb doesn't affect the 69kb at the beginning.
> >
> > Hmm.. in dmesg (6.4) I see 8388608 bytes = 8 MB.
> >
> > >
> > > > 
> > > > Instead, in the TPM2 code path:
> > > > 
> > > > 		start = tpm2_phy->log_area_start_address;
> > > > 		if (!start || !len) {
> > > > 			acpi_put_table((struct acpi_table_header *)tbl);
> > > > 			return -ENODEV;
> > > > 		}
> > > > 
> > > > 		if (len > TPM_MAX_LOG_SIZE) {
> > > > 			dev_warn(&chip->dev, "Excessive TPM2 log size of %llu bytes (> %u)\n",
> > > > 				 len, MAX_TPM_LOG_LEN);
> > > > 			log->bios_event_log = start;
> > > > 			chip->flags |= TPM_CHIP_FLAG_TPM2_ACPI;
> > > > 			return 0;
> > > > 		}
> > > > 
> > > > This can then be used in tpm2.c to create a "slow path" in tpm2.c for
> > > > parsing TPM2 ACPI log directly by mapping IO memory.
> > >
> > > I thought the problem when getting request for 8MB is the code a bit 
> > > further below from here that cannot allocated the 8MB.
> > >
> > >   	/* malloc EventLog space */
> > >   	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> > >   	if (!log->bios_event_log)
> >
> > Truncating the log would make it invalid, or what I'm not seeing?
> >
> > 1. Quick fix: Disable the log if the size surpasses the max. Export
> >    logs as an empty file so that user space can detect the condition.
> > 2. Proper fix: In tpm2.c call acpi_os_map_iomem() if the size
> >    surpasses the max, and e.g. use memcpy_fromio() to access it.
> >
> > In both cases: don't call devm_kmalloc().
> >
> > Maybe I lost the track. I'm assuming here that the reporter thinks
> > that 8 MB is somehow legit log size since there is even this recent
> > comment:
> >
> > "The TPM2 DUMP still shows the TPM event log size as 8MB. Thank you."
> >
> > My personal opinion is that we should not fix this at all because:
> >
> > 1. Kernel is not the latest mainline. It's 6.4 and I'm not even
> >    sure if it is distribution kernel or pure mainline.

The reporter tested the recent upstream, too.

Also I provided the reporter the build of the upstream kernel with
Stefan's patch.

> > 2. No detailed description of the hardware. Some imaginary
> >    hardware does stupid shit with unknown BIOS and ages old
> >    kernel that is compiled from God knows what source tree.

Again, you can forget about your argument about the kernel version.
The recent upstream kernel has been already checked.
The details of the hardware can be improved by the reporter, though.

About BIOS: yes, we all know that BIOS is buggy as always.  And we all
know that we do tons of workarounds in the kernel side, just because
we can't be optimistic and expect that BIOS shall be fixed later.
(With the long-time subsystem maintainer hat on, I have to tell you
that it's truth, unfortunately...) 

So, if this issue is handled exceptionally and we must ignore the bug,
we'd love to hear the compelling reason.   e.g. if the suggested fix
is way too ugly, then it'd be understandable.  But, to my eyes,
setting the upper bound of the log size is rather a safer move in
general.

> > This does not hold:
> >
> > "
> > Please don't shoot the messenger.  Neither of the original report and I
> > understand / manage the relevant code better than you subsystem
> > maintainers.
> >
> > If you can give a patch for testing, I can build a test kernel and ask
> > the original reporter, of course.  Thanks!
> > "
> >
> > A messenger telling a tale or lore is not my cup of tea, and without
> > better description, I don't proactively encourage to work on this...

Huh?  A messenger is a messenger; I don't own any relevant hardware or
whatever information you asked *at all*.  You've been simply hitting a
very wrong person.


thanks,

Takashi

