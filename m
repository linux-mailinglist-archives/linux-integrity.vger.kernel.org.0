Return-Path: <linux-integrity+bounces-5544-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A77A78767
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 06:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2BA3AEF06
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 04:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E65230273;
	Wed,  2 Apr 2025 04:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2obdgh8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9661624D5
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743569416; cv=none; b=u27xDiG9FpWz3c9F9PQe3taqF5D5xBkaYwcGospleFjyscSfJsnSsB1tb6KpV3MkPhOXw3QEcHyjxal580KESR8PbZEDyxvqJTEVXpC5bDNt60l20AJdSDxtH0yl5ZJOO/OrrSg/D1D1PrnrK2dLZNneHn8D1B0+Q+WaczeP4r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743569416; c=relaxed/simple;
	bh=isebNrf2esoUGpP65SmaxzofRltSgMUSebkM3amp5AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jSxpmuP0yjVJ4bO86YVYNzJN9A5KJg2gPvpIre9yT+Is7qdVHpZy4CN0Up612QOThdk5gCRFgKEUPlOrA+A9rhkgCNpG7iw7IWGSpq1bFPH5fnLjRkcLXmXCpPPXt0bzW4XPvmxZVFpAXQccle1Va2YPn4B3u8HlyuGdVDsJz94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2obdgh8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac34257295dso151189266b.2
        for <linux-integrity@vger.kernel.org>; Tue, 01 Apr 2025 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743569412; x=1744174212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAlu+ltVRWjSYmA5Gp5XEU5Z7YgITnX8VX3GMZmf9c0=;
        b=Q2obdgh8U9s9Sn5qQFgiWAJ/447316iyiIk9v7DP9kntIoyzSba0FNL9jIvjL5yBKk
         1Cuaq5NS0ZF/O2/zJnY0xxmMtAvGHfzAfPSbQJWgLfe9tZ8ebru0z40AB2ca0Pcm5RCr
         +nBE3dn16uirkfHPoWAgHy7VCpqpNtDxkmy2EwTu4JCmyXlIczsGmRc6lSKQFRb2Mn51
         Z7z+yHUNI76LJOyjoZPmH0+IrovC8h3mIOJRQcfyAz2FNJjYFb8fJiTMDhTw7itxx0cN
         bSXnr4y2B25L0ENf+usxs9xaWy+3tEgqCXKr6Dgo12FJqu/zZlkdj+YeIzlOBKCYuF1W
         Uhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743569412; x=1744174212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAlu+ltVRWjSYmA5Gp5XEU5Z7YgITnX8VX3GMZmf9c0=;
        b=BDhZLmLDjipVIVPZyfE5nLOkBTx9PkK97WKzFBwIw51HnNUJK2NE7ud8yHjcFnMzS0
         AEOGpdX3yAndECCoE+nRmFGczTAgLZhLPAB5TcI5GKU8eH9+xP0CEyICeUoQF81FsjbQ
         OFKWlHf24xIn3av1q0WSYzgqaVw4d90J/5B+pr2dutzplhThmpjwZj87bbcrVdVkT3ig
         YnGiI1jYY8lfs6+efp6OuXwgoi208bS+pzZB02uwn8smBARe9MXV0SHy7eh/NGw/0VzM
         sHh9ETcyRH1VDl0rWV76uvvt2DmzN2N1ehynq4c55V5FqUa96Bvs3ZgQim/XXxvzvs61
         RZrg==
X-Forwarded-Encrypted: i=1; AJvYcCVf0Wgl8kXmWqTBPEN/ifeE57iFxtzFXLU7aq6m4+48hr3E9dQsLKoa7zgcN6dksPJn5Y7VKgo1p9nM3vQ/sUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Afzz1espjkDKBf9ldWCzjHu8qfNlY0ilckDuwKZttAY0wigm
	K18hGYd6G7mqtbtOSMY4oEnc/9/gJUGFi6QnLbNphgoK8x5vu43cywt9ib7q93UMHM1W5TgCTml
	OHV6dLVf88EWtwbQoCEx3U/qK06sNEF5yFwN4
X-Gm-Gg: ASbGncuwM2H0iKVsHIk6ejDh2w3EKH1776pGN/cnoE02KWW7w/gk+btdRNFIGjSWe+V
	jjOxlcDI+XiVjULAHoR5wjifO0fuSTXtAqiNsQ/qr70m7duryv4XtkOl43WrKClk6+sVl3CqNmS
	AFTaQzTWb73yzXRuijWlTOCkGTKw==
X-Google-Smtp-Source: AGHT+IEO30ME7eSMcTeelbOr3WHn7l+8jLOV3Rh2RF8FpgyLrbYT3cBg4cAKLmxezZ1OAfFGtdfWV5/3D1abll702Mg=
X-Received: by 2002:a17:907:7da7:b0:ac7:19d3:1b2 with SMTP id
 a640c23a62f3a-ac7389edd03mr1209228466b.18.1743569411948; Tue, 01 Apr 2025
 21:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331103900.92701-1-sgarzare@redhat.com> <20250331103900.92701-2-sgarzare@redhat.com>
 <CAAH4kHYWT_LhxciFgEpG4wTRstZsY3grjrL0zjbERzrPyQZ9rw@mail.gmail.com>
In-Reply-To: <CAAH4kHYWT_LhxciFgEpG4wTRstZsY3grjrL0zjbERzrPyQZ9rw@mail.gmail.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Tue, 1 Apr 2025 21:50:00 -0700
X-Gm-Features: AQ5f1JqISR008aUW6iF3QtvXScRkhHvlKh8Noq97ar4eYwt7xn7MXs-U6YueRb8
Message-ID: <CAAH4kHb7sAHkU3W6RwYP60EQiOnHqsL6nksU-_GQ+nuyG5XU1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] x86/sev: add SVSM vTPM probe/send_command functions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, linux-coco@lists.linux.dev, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <jroedel@suse.de>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:13=E2=80=AFPM Dionna Amalie Glaze
<dionnaglaze@google.com> wrote:
>
> On Mon, Mar 31, 2025 at 3:39=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > Add two new functions to probe and send commands to the SVSM vTPM.
> > They leverage the two calls defined by the AMD SVSM specification [1]
> > for the vTPM protocol: SVSM_VTPM_QUERY and SVSM_VTPM_CMD.
> >
> > Expose these functions to be used by other modules such as a tpm
> > driver.
> >
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> >
> > Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com=
>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v5:
> > - added stubs when !CONFIG_AMD_MEM_ENCRYPT [Dionna]
> > - added Jarkko's R-b
> > v4:
> > - added Tom's R-b
> > - added functions documentation [Jarkko]
> > - simplified TPM_SEND_COMMAND check [Tom/Jarkko]
> > v3:
> > - removed link to the spec because those URLs are unstable [Borislav]
> > - squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
> >   in this one [Borislav]
> > - slimmed down snp_svsm_vtpm_probe() [Borislav]
> > - removed features check and any print related [Tom]
> > ---
> >  arch/x86/include/asm/sev.h |  9 ++++++
> >  arch/x86/coco/sev/core.c   | 59 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> > index ba7999f66abe..ba7a0a327afb 100644
> > --- a/arch/x86/include/asm/sev.h
> > +++ b/arch/x86/include/asm/sev.h
> > @@ -384,6 +384,10 @@ struct svsm_call {
> >  #define SVSM_ATTEST_SERVICES           0
> >  #define SVSM_ATTEST_SINGLE_SERVICE     1
> >
> > +#define SVSM_VTPM_CALL(x)              ((2ULL << 32) | (x))
> > +#define SVSM_VTPM_QUERY                        0
> > +#define SVSM_VTPM_CMD                  1
> > +
> >  #ifdef CONFIG_AMD_MEM_ENCRYPT
> >
> >  extern u8 snp_vmpl;
> > @@ -481,6 +485,9 @@ void snp_msg_free(struct snp_msg_desc *mdesc);
> >  int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_gues=
t_req *req,
> >                            struct snp_guest_request_ioctl *rio);
> >
> > +bool snp_svsm_vtpm_probe(void);
> > +int snp_svsm_vtpm_send_command(u8 *buffer);
> > +
> >  void __init snp_secure_tsc_prepare(void);
> >  void __init snp_secure_tsc_init(void);
> >
> > @@ -524,6 +531,8 @@ static inline struct snp_msg_desc *snp_msg_alloc(vo=
id) { return NULL; }
> >  static inline void snp_msg_free(struct snp_msg_desc *mdesc) { }
> >  static inline int snp_send_guest_request(struct snp_msg_desc *mdesc, s=
truct snp_guest_req *req,
> >                                          struct snp_guest_request_ioctl=
 *rio) { return -ENODEV; }
> > +static inline bool snp_svsm_vtpm_probe(void) { return false; }
> > +static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENO=
DEV; }
> >  static inline void __init snp_secure_tsc_prepare(void) { }
> >  static inline void __init snp_secure_tsc_init(void) { }
> >
> > diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> > index b0c1a7a57497..efb43c9d3d30 100644
> > --- a/arch/x86/coco/sev/core.c
> > +++ b/arch/x86/coco/sev/core.c
> > @@ -2625,6 +2625,65 @@ static int snp_issue_guest_request(struct snp_gu=
est_req *req, struct snp_req_dat
> >         return ret;
> >  }
> >
> > +/**
> > + * snp_svsm_vtpm_probe() - Probe if SVSM provides a vTPM device
> > + *
> > + * This function checks that there is SVSM and that it supports at lea=
st
> > + * TPM_SEND_COMMAND which is the only request we use so far.
> > + *
> > + * Return: true if the platform provides a vTPM SVSM device, false oth=
erwise.
> > + */
> > +bool snp_svsm_vtpm_probe(void)
> > +{
> > +       struct svsm_call call =3D {};
> > +
> > +       /* The vTPM device is available only if a SVSM is present */
> > +       if (!snp_vmpl)
> > +               return false;
> > +
> > +       call.caa =3D svsm_get_caa();
> > +       call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_QUERY);
> > +
> > +       if (svsm_perform_call_protocol(&call))
> > +               return false;
> > +
> > +       /* Check platform commands contains TPM_SEND_COMMAND - platform=
 command 8 */
> > +       return call.rcx_out & BIT_ULL(8);
> > +}
> > +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_probe);
> > +
> > +/**
> > + * snp_svsm_vtpm_send_command() - execute a vTPM operation on SVSM
> > + * @buffer: A buffer used to both send the command and receive the res=
ponse.
> > + *
> > + * This function executes a SVSM_VTPM_CMD call as defined by
> > + * "Secure VM Service Module for SEV-SNP Guests" Publication # 58019 R=
evision: 1.00
> > + *
> > + * All command request/response buffers have a common structure as spe=
cified by
> > + * the following table:
> > + *     Byte      Size       In/Out    Description
> > + *     Offset    (Bytes)
> > + *     0x000     4          In        Platform command
> > + *                          Out       Platform command response size
> > + *
> > + * Each command can build upon this common request/response structure =
to create
> > + * a structure specific to the command.
> > + * See include/linux/tpm_svsm.h for more details.
> > + *
> > + * Return: 0 on success, -errno on failure
> > + */
> > +int snp_svsm_vtpm_send_command(u8 *buffer)
> > +{
> > +       struct svsm_call call =3D {};
> > +
> > +       call.caa =3D svsm_get_caa();
> > +       call.rax =3D SVSM_VTPM_CALL(SVSM_VTPM_CMD);
> > +       call.rcx =3D __pa(buffer);
> > +
> > +       return svsm_perform_call_protocol(&call);
> > +}
> > +EXPORT_SYMBOL_GPL(snp_svsm_vtpm_send_command);
> > +
>
> How do we prevent this from causing scheduler problems when the TPM
> service decides to take a really long time?
> I removed the create_ek_2048 operation at boot in favor of lazily
> creating it on first use.
>
> This attest protocol uses tpm_send_command under the hood and
> demonstrates the problem.
> When I use this for CreatePrimary for an RSA 2048 key, the vCPU goes
> out to lunch
>
> [ 3356.509143] Sending NMI from CPU 1 to CPUs 0:
> [ 2503.241673] NMI backtrace for cpu 0
> [ 2503.241673] CPU: 0 PID: 462 Comm: cat Not tainted 6.6.84 #1
> [ 2503.241673] Hardware name: Google Google Compute Engine/Google
> Compute Engine, BIOS Google 01/01/2011
> [ 2503.241673] RIP: 0010:svsm_perform_call_protocol+0x1ee/0x310
> [ 2503.241673] Code: c2 48 c1 ea 20 b9 30 01 01 c0 0f 30 48 8b 3b 48
> 8b 43 08 48 8b 4b 10 48 8b 53 18 4c 8b 43 20 4c 8b 4b 28 c6 07
> 01 f3 0f 01 d9 <48> 8b 3b 45 31 d2 44 86 17 48 89 43 30 48 89 4b 38 48
> 89 53 40 4c
> [ 2503.241673] RSP: 0018:ffffc90000f93ba8 EFLAGS: 00000012
> [ 2503.241673] RAX: 0000000080000000 RBX: ffffc90000f93c98 RCX:
> 000000013ffe8008
> [ 2503.241673] RDX: ffffffffffffffff RSI: ffff88813ffe9000 RDI:
> ffff88813ffe8000
> [ 2503.241673] RBP: ffffc90000f93bf8 R08: ffffffffffffffff R09:
> 0000000000000000
> [ 2503.241673] R10: 0000000000000000 R11: 0000000080000000 R12:
> 0000000080000018
> [ 2503.241673] R13: ffff88813ffe93f0 R14: 00000000ffffffea R15:
> ffff8881bffe9000
> [ 2503.241673] FS:  00007d3490351800(0000) GS:ffff88813bc00000(0000)
> knlGS:0000000000000000
> [ 2503.241673] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2503.241673] CR2: 00007d349032f000 CR3: 00080001012d8003 CR4:
> 0000000000770ef0
> [ 2503.241673] PKRU: 55555554
> [ 2503.241673] Call Trace:
> [ 2503.241673]  <NMI>
> [ 2503.241673]  ? nmi_cpu_backtrace+0xe2/0x110
> [ 2503.241673]  ? nmi_cpu_backtrace_handler+0x15/0x20
> [ 2503.241673]  ? nmi_handle+0x7f/0x140
> [ 2503.241673]  ? svsm_perform_call_protocol+0x1ee/0x310
> [ 2503.241673]  ? default_do_nmi+0x46/0x100
> [ 2503.241673]  ? exc_nmi+0x111/0x190
> [ 2503.241673]  ? end_repeat_nmi+0x16/0x67
> [ 2503.241673]  ? svsm_perform_call_protocol+0x1ee/0x310
> [ 2503.241673]  ? svsm_perform_call_protocol+0x1ee/0x310
> [ 2503.241673]  ? svsm_perform_call_protocol+0x1ee/0x310
> [ 2503.241673]  </NMI>
> [ 2503.241673]  <TASK>
> [ 2503.241673]  snp_issue_svsm_attest_req+0xa7/0xf0
> [ 2503.241673]  sev_report_new+0x58e/0xb20
> [ 2503.241673]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2503.241673]  tsm_report_read+0x153/0x330
> [ 2503.241673]  configfs_bin_read_iter+0xbf/0x200
> [ 2503.241673]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ 2503.241673]  vfs_read+0x25e/0x2f0
> [ 2503.241673]  ksys_read+0x75/0xe0
> [ 2503.241673]  do_syscall_64+0x46/0xb0
> [ 2503.241673]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> [ 2503.241673] RIP: 0033:0x7d348ff281cd
> [ 2503.241673] Code: 31 c0 e9 d6 fe ff ff 55 48 8d 3d a6 0a 0a 00 48
> 89 e5 e8 c6 1c 02 00 66 0f 1f 44 00 00 80 3d 31 62 0d 00 00 74
> 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 2e 0f 1f 84 00 00 00 00
> 00 55 48 89
> [ 2503.241673] RSP: 002b:00007ffc71e50a88 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000000
> [ 2503.241673] RAX: ffffffffffffffda RBX: 00007d3490330000 RCX:
> 00007d348ff281cd
> [ 2503.241673] RDX: 0000000000020000 RSI: 00007d3490330000 RDI:
> 0000000000000003
> [ 2503.241673] RBP: 00007ffc71e50ab0 R08: 00007d349032f010 R09:
> 0000000000000000
> [ 2503.241673] R10: 0000000000000022 R11: 0000000000000246 R12:
> 0000000000020000
> [ 2503.241673] R13: 0000000000000000 R14: 0000000000000003 R15:
> 0000000000020000
> [ 2503.241673]  </TASK>
>

Disregard this error. I was providing the wrong command. I don't
experience any such hang now.

>
> Which doesn't seem like behavior we want, nor is it something I have
> any idea how we solve with the synchronous SVSM call model.
>
> >  static struct platform_device sev_guest_device =3D {
> >         .name           =3D "sev-guest",
> >         .id             =3D -1,
> > --
> > 2.49.0
> >
>
>
> --
> -Dionna Glaze, PhD, CISSP, CCSP (she/her)



--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

