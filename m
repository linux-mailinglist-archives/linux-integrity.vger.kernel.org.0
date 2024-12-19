Return-Path: <linux-integrity+bounces-4418-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B59F7E15
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 16:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB715161DFD
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Dec 2024 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4E226168;
	Thu, 19 Dec 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxrZsZIc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118522579E;
	Thu, 19 Dec 2024 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734622146; cv=none; b=YvWRSF2vjJgUr4eDtnlII1WbgGjOuVvjvevw6JOixoQqreC/JHzg/L632UD8GmWgxtq9e1TzEj0YQjMmJlzW1qpHmTesIOtCfZlLc4VKwIP1ONc5wHrHwmXU2fYEx3dHKop1kPnw3Ejfs0TYoAWCHFQtj/COSLijdlx8M6u1gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734622146; c=relaxed/simple;
	bh=pwI/XjCrTmM+3zInTyj3tywcztPolSD2Nz8dS3ZAYNE=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=WmA7HxR0jo1VkVBojZ4IpS3zji/sg1ioK8q3wTqfZGomdGu9hg5KDtiPjUCgCRVBer3YnOhJjIp+5gkDIUsCPBx4hO1BRj1P5G/N5H6ozb2sRYmJW8/3VTOQ3K0XaNLtejd9DFKksRo44dymQhOea/uSzXS86wzzthuOpGPDeRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxrZsZIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5436CC4CECE;
	Thu, 19 Dec 2024 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734622145;
	bh=pwI/XjCrTmM+3zInTyj3tywcztPolSD2Nz8dS3ZAYNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxrZsZIcdn9aNyJOaUSH8sHLJgkKLs99FMT5Huz6oSK2m6ChlbaLpmusYIbjDAIG9
	 hNkTGp8RrzQCHRSNTvg1nATv73OAmfFi2vb0ZUyK8jzLX30MgEr36QxbjDSLrKGheU
	 zpFs0azeMenl3oQWRloZeqILtyk2OlI4y6tH7uE+95I0DQZJEoIbcXoS7eVCzIX4EP
	 JXhcgBzb9EBc1afmBaEzz5LyNFjM7SBH3ne2ofb6njtVot3l4+dU+LThq5+mxXatfy
	 sR/fiHd1I71VNAZe8zdn3zX1JCsNyH2VJQV7iDLbBRjdCiCkEGk2S74IUKw1I1yyGQ
	 qD8OkjISRxhIA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 17:29:01 +0200
Message-Id: <D6FS8ALS4HSV.2CSS6SGE8ND09@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>,
 <linux-integrity@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>,
 "Takashi Iwai" <tiwai@suse.de>
Subject: Re: [PATCH] tpm/eventlog: Limit memory allocations for event logs
 with excessive size
X-Mailer: aerc 0.18.2
References: <20241210222608.598424-1-stefanb@linux.ibm.com>
 <D6B49LBSZXN4.3V519030X0YCG@kernel.org>
 <709d3abb-d94d-44fc-a730-054139b13188@linux.ibm.com>
In-Reply-To: <709d3abb-d94d-44fc-a730-054139b13188@linux.ibm.com>

On Mon Dec 16, 2024 at 9:29 PM EET, Stefan Berger wrote:
>
>
> On 12/13/24 10:51 PM, Jarkko Sakkinen wrote:
> > On Wed Dec 11, 2024 at 12:26 AM EET, Stefan Berger wrote:
> >> The TPM2 ACPI BIOS eventlog of a particular machine indicates that the
> >> length of the log is 4MB, even though the actual length of its useful =
data,
> >> when dumped, are only 69kb. To avoid allocating excessive amounts of m=
emory
> >> for the event log, limit the size of any eventlog to 128kb. This shoul=
d be
> >> sufficient memory and also not unnecessarily truncate event logs on an=
y
> >> other machine.
> >>
> >> Reported-by: Andy Liang <andy.liang@hpe.com>
> >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> >> Cc: Takashi Iwai <tiwai@suse.de>
> >> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >> ---
> >>   drivers/char/tpm/eventlog/acpi.c | 8 ++++++++
> >>   1 file changed, 8 insertions(+)
> >>
> >> diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/event=
log/acpi.c
> >> index 69533d0bfb51..701fd7d4cc28 100644
> >> --- a/drivers/char/tpm/eventlog/acpi.c
> >> +++ b/drivers/char/tpm/eventlog/acpi.c
> >> @@ -26,6 +26,8 @@
> >>   #include "../tpm.h"
> >>   #include "common.h"
> >>  =20
> >> +#define MAX_TPM_LOG_LEN		(128 * 1024)
> >=20
> > Instead, to common.h:
> >=20
> > /*
> >   * Cap the log size to the given number of bytes. Applied to the TPM2
> >   * ACPI logs.
> >   */
> > #define TPM_MAX_LOG_SIZE (128 * 1024)
>
> Done.
>
> >=20
> >>
q >> +
> >>   struct acpi_tcpa {
> >>   	struct acpi_table_header hdr;
> >>   	u16 platform_class;
> >> @@ -135,6 +137,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >>   		return -EIO;
> >>   	}
> >>  =20
> >> +	if (len > MAX_TPM_LOG_LEN) {
> >> +		dev_warn(&chip->dev, "Excessive TCPA log len %llu truncated to %u b=
ytes\n",
> >> +			 len, MAX_TPM_LOG_LEN);
> >> +		len =3D MAX_TPM_LOG_LEN;
> >> +	}
> >=20
> > First, you are changing also TPM1 code path. Also in the case of
>
> Ok, let's move it into the TPM2 code path then.
>
> > TPM2 code path the log message is incorrect as TCPA does not exist.
> >=20
> > Second, this does not make sense as the log ends up to be corrupted
> > (i.e. not complete).
>
> Truncating the log is something I am trying to prevent by giving it a=20
> generous size of 128 kb:
> "To avoid allocating excessive amounts of memory
> for the event log, limit the size of any eventlog to 128kb. This should b=
e
> sufficient memory and also not unnecessarily truncate event logs on any
> other machine."
>
> The 8MB the machine with the faulty BIOS indicates are holding 69kb of=20
> log data at the beginning and then unnecessary data after that. So=20
> truncating this one to 128kb doesn't affect the 69kb at the beginning.

Hmm.. in dmesg (6.4) I see 8388608 bytes =3D 8 MB.

>
> >=20
> > Instead, in the TPM2 code path:
> >=20
> > 		start =3D tpm2_phy->log_area_start_address;
> > 		if (!start || !len) {
> > 			acpi_put_table((struct acpi_table_header *)tbl);
> > 			return -ENODEV;
> > 		}
> >=20
> > 		if (len > TPM_MAX_LOG_SIZE) {
> > 			dev_warn(&chip->dev, "Excessive TPM2 log size of %llu bytes (> %u)\n=
",
> > 				 len, MAX_TPM_LOG_LEN);
> > 			log->bios_event_log =3D start;
> > 			chip->flags |=3D TPM_CHIP_FLAG_TPM2_ACPI;
> > 			return 0;
> > 		}
> >=20
> > This can then be used in tpm2.c to create a "slow path" in tpm2.c for
> > parsing TPM2 ACPI log directly by mapping IO memory.
>
> I thought the problem when getting request for 8MB is the code a bit=20
> further below from here that cannot allocated the 8MB.
>
>   	/* malloc EventLog space */
>   	log->bios_event_log =3D devm_kmalloc(&chip->dev, len, GFP_KERNEL);
>   	if (!log->bios_event_log)

Truncating the log would make it invalid, or what I'm not seeing?

1. Quick fix: Disable the log if the size surpasses the max. Export
   logs as an empty file so that user space can detect the condition.
2. Proper fix: In tpm2.c call acpi_os_map_iomem() if the size
   surpasses the max, and e.g. use memcpy_fromio() to access it.

In both cases: don't call devm_kmalloc().

Maybe I lost the track. I'm assuming here that the reporter thinks
that 8 MB is somehow legit log size since there is even this recent
comment:

"The TPM2 DUMP still shows the TPM event log size as 8MB. Thank you."

My personal opinion is that we should not fix this at all because:

1. Kernel is not the latest mainline. It's 6.4 and I'm not even
   sure if it is distribution kernel or pure mainline.
2. No detailed description of the hardware. Some imaginary
   hardware does stupid shit with unknown BIOS and ages old
   kernel that is compiled from God knows what source tree.

This does not hold:

"
Please don't shoot the messenger.  Neither of the original report and I
understand / manage the relevant code better than you subsystem
maintainers.

If you can give a patch for testing, I can build a test kernel and ask
the original reporter, of course.  Thanks!
"

A messenger telling a tale or lore is not my cup of tea, and without
better description, I don't proactively encourage to work on this...

  =20
BR, Jarkko

