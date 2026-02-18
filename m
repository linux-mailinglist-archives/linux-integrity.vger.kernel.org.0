Return-Path: <linux-integrity+bounces-8515-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOFrAEU1lmkkcQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8515-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 22:55:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CE115A71B
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 22:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB513029E53
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 21:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E7533123D;
	Wed, 18 Feb 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="pRs5B5ix"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4431A049
	for <linux-integrity@vger.kernel.org>; Wed, 18 Feb 2026 21:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451708; cv=pass; b=lar98rA54L7Z4ooxg2GY75Cr9WHxRzbl0TMOxHSJMU8zp8ScqXcmUEZevbj7+CX4B7LbbRHkTj0ELy/uV6hZ5wYtE73frqZFcQNUUpwC5CChHNeRay9XCtiSI9IEHWOT/kGFW++T3heD0BnCvzsDeYV2W8f2KTEfpvA+TBNlRgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451708; c=relaxed/simple;
	bh=DtMCBbJ603M+9lFH3b7cqRU6jOZc0GNXvqZDaNm0YIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeiWyr4nitjWiQl5Ef4+CnM8qVBfVKpzwMTIoDzkeDoEZ8AgplJd9C8BVRdS4Z7/CwWqLJGL9JVPCE7hkW/2cA0shMpOwBzVtO6XT9zBM047HPxNiUh+hm7NfWfvq/Fu0vaZGP9vlpJZIs4tgkcaqV66wyF7Azncmu5F/IYMbzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=pRs5B5ix; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e60925251so342623e87.3
        for <linux-integrity@vger.kernel.org>; Wed, 18 Feb 2026 13:55:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771451705; cv=none;
        d=google.com; s=arc-20240605;
        b=e9VCo8PNL/ppAkJULywgDiB/XLgIbUnLd1+CU/no0rM+OSnmCq4igACfXGq7sMRHz/
         oaikwfwg+dLl59/kyaVYWqdUFNSCjmwb9qiT9BNPBeGnDTbLQ3X/Tvk9nuf7xSaBUYnG
         vqNOi9ax8Vk9SQ1xCSERNNXBRJE9j/CXK8BHR7yKO+uPxXCwTTp5QLfPqIXSXnN9Il1d
         pHdOPkGlrLV5GilNHNunYUoXIJU7OpUykf8wf8Sxkeio0MttA5E5iLme56/6BYBr29xO
         SMidibELlbNPURfGh3+ERMwv+6ewmiOq0p4NLc/ZZhySawnvPk3+E6Uv+HKNTNFQckcP
         /I8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        fh=qz/aiLJMu2Pb+FJ/g1kPbm1j9Pyir9su3ZJI0iSI1ZM=;
        b=d2iUBge0UjPBv/kiaYTasCpYZxshM/wPnos0NyfNRU2OlSvWceLvEp9ur8AoLBqmN0
         dt4NvhiNOv6c9vZvk36U+FEBngzFbPFwT27IRopiRXfCrNcqKB7w0kje/wwfslM1tkSr
         r6ly+8eFNUQGfAiWUA4xmybidazmGoyMbPlSDLBPlTd84Y4l8lPJmExAfZgECnEGU7oO
         SSl3NjT3C4abbzT9iThNbC2SsMVsDW/F+2inrbG0jSfXRksD7ek0ovFxg4jAVEaOxJ11
         v4Y4SNk5j3EyldAnVsi3UZBRjTUF4RhBm6y10u2zIZM45gVzSVsYpG+ibDcXnpGYVxCL
         eDtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771451705; x=1772056505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=pRs5B5ixqZAoZ/MuQdcDAKL060Wdyz+aZ0N43KGNlKbESCH1SfUhAdTsjTbHtXH8A4
         AsN9gTBlySg+NddHpkoQZs3w3sxlRpYSKErlsHPZ9/lZYmiQURfD8oAszAQ7ObA6GGtx
         rVurIm65lZ8pLNFrEtIYocMnjNGdBQ/7U8fIqObvUvWA/ptxkuzNkZ/c3F+eg+24zgSu
         ZrmHwR52UomBtGZIYFHgQqF2NBX5iQudF5SqS5glJTWUWE+bTblFybo7lMn/qzRUP4MC
         kb+fQ3P5Rnm15fTO1FyR+MyH7W1EdEJAWmfbUfvf41SXdyY0KtEA+p+HsWX4C5F3XnMl
         0XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771451705; x=1772056505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6id67RYm+WkjGu//HTup/gkJF0wPsfSPDN/OaX8LFM=;
        b=YWDa+LOo+E3YrPhqQjwaq5Gv8LUBLpen1X/Zgr2cdw6fMpgcVlr/gp2GzYoTxIuYyn
         J2bQIlBXo3+SySyJQnyc7S77bR4zHULD74M9ACNIaDzGHNXyHfXc18DQzIYpmx+4l0Lh
         AzInhEfjDH2cm78Iq3dDw/n83BVMG+fdKL9/QXr7Wfp0NMLqR2xAcJgB1nfei6i5sJzG
         MdF9VMF3ulclivnn/7Q/IcsT0qVnTzwJ4rtFQW3ovCe1+eRG7kW89K6pUZ0xjOSvMCVF
         lmV4hAawN5acHLhKpsKxN/y0FEbh2+MlVlDiycDcNxi9P3OuFeApZcldYQkFdcOFvP5m
         OxdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZW05mJ3XWv1rsh9N7s07aSnHgKjK6on+Rhpa3v7EDaWwQ075AxTJz4px/Sq+1zgylIP7ySjLBdfipmkxGjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhvqEm4HzlKV15LT2GgfqGG1GclxwfxKLLTKLU7QCUEnt91YHD
	lWhhqxY3BJLNinr67wPkHZS2jPTiS9DOscTBJJfIPfLAg0UA8667hFNAM1uV0XSIMymD0mHSqsG
	PZd07AmBhdFAnHMyCMq+chSlEqjMehAseIEe41ttn
X-Gm-Gg: AZuq6aIj4vBlaPlWrwxrpMmmsOJMLx0NLb7cA61wGIh6Cgd2AVjVpYIYDG43F9tE31t
	CCod4iflRe3Kj8Xvzb8ghuO69PQGDlRuL9FnjXnEbxBK2G8peKscjBFRSMvxiEugRhvSF2yyS7D
	e7Eq6YpeamHe91wGXuODdrftqsEAZ9uVF/ratZe7p5ui1jq3yPhn1J9761s7Dl7Xvs1e6vetmbf
	iuZ/eBN/izvObq+1t+fMaYdIj+ASmU/TmW7QtM7U7EvwcaGuarMtjmC2ow2j0OAOWXSv6numq8F
	olRB
X-Received: by 2002:a05:6512:304d:b0:59e:1880:2ef6 with SMTP id
 2adb3069b0e04-59f69c0f33dmr5396130e87.10.1771451704704; Wed, 18 Feb 2026
 13:55:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
In-Reply-To: <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 13:54:53 -0800
X-Gm-Features: AaiRm50_oD7OC0ANa5Bzl9PQloeEGVtFI0Bz_O-wbD80wJJi63Y8TTUsLaV64pE
Message-ID: <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Simo Sorce <simo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	TAGGED_FROM(0.00)[bounces-8515-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zytor.com,kernel.org,apertussolutions.com,oracle.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_TWELVE(0.00)[32];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 55CE115A71B
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wrote:
>
> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com>=
 wrote:
> > >
> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapita=
l.net> wrote:
> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kerne=
l.org> wrote:
> > > > >
> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> > > > > ...
> > > > > > > Surprisingly, even when doing a secure launch, the EFI runtim=
e services still work happily, which means (AIUI) that code that was exclud=
ed from the D-RTM TCB is still being executed at ring 0? Doesn't this defea=
t D-RTM entirely in the case some exploit is hidden in the EFI runtime code=
? Should we measure the contents of EfiRuntimeServicesCode regions too?
> > > > > >
> > > > > > Yes, in fact in the early days I specifically stated that we sh=
ould
> > > > > > provide for the ability to measure the RS blocks. Particularly =
if you
> > > > > > are not in an environment where you can isolate the calls to RS=
 from the
> > > > > > TCB. While the RS can pose runtime corruption risks, the larger=
 concern
> > > > > > is integrating the D-RTM validation of the Intel System Resourc=
es
> > > > > > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by t=
he Intel
> > > > > > System Security Report (ISSR). Within the ISSR is a list of mem=
ory
> > > > > > regions which the SMM Policy Shim (SPS) restricts a SMI handler=
's access
> > > > > > when running. This allows a kernel to restrict what access a SM=
I handler
> > > > > > are able to reach, thus allowing them to be removed from the TC=
B when
> > > > > > the appropriate guards are put in place.
> > > > > >
> > > > > > If you are interested in understanding these further, Satoshi T=
anda has
> > > > > > probably the best technical explanation without Intel market sp=
eak.
> > > > > >
> > > > > > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> > > > > > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> > > > > >
> > > > >
> > > > > Thanks, I'll take a look at those.
> > > > >
> > > > > But would it be better to disable the runtime services by default=
 when doing a secure launch? PREEMPT_RT already does the same.
> > > >
> > > > So I have a possible way to disable EFI runtime service without los=
ing
> > > > the ability to write EFI vars.  We come up with a simple file forma=
t
> > > > to store deferred EFI var updates and we come up with a place to pu=
t
> > > > it so that we find it early-ish in boot the next time around.  (Thi=
s
> > > > could be done via integration with systemd-boot or shim some other
> > > > boot loader or it could actually be part of the kernel.)  And then,
> > > > instead of writing variables directly, we write them to the deferre=
d
> > > > list and then update them on reboot (before TXT launch, etc).  [0]
> > > > This would be a distincly nontrivial project and would not work for
> > > > all configurations.
> > > >
> > > > As a maybe less painful option, we could disable EFI runtime servic=
es
> > > > but have a root-writable thing in sysfs that (a) turns them back on
> > > > but (b) first extends a PCR to say that they're turned back on.
> > > >
> > > > (Or someone could try running runtime services at CPL3...)
> > > >
> > > > [0] I have thought for years that Intel and AMD should do this on
> > > > their end, too.  Keep the sensitive part of SMI flash entirely lock=
ed
> > > > after boot and, instead of using magic SMM stuff to validate that
> > > > write attempts have the appropriate permissions and signatures, que=
ue
> > > > them up as deferred upates and validate the signatures on the next
> > > > boot before locking flash.
> > > >
> > >
> > > *If* a physical EFI partition exists there is a lot to be said for th=
is approach.
> > >
> > > The only issue with this that I can see is for things like network or=
 CD/DVD booting where there isn't necessarily any EFI boot partition, it mi=
ght not be writable, or it might not be persistent (e.g. http booting typic=
ally uses a ramdisk, like the old Linux initrd.)
> >
> > Hmm, I guess my approach is a 100% complete nonstarter for installing
> > Linux from a CD, and it's really not awesome for installing Linux from
> > a USB stick.
>
> Doing any of this on a removable device feels generally like a trap.
> You get your USB disk in, try to boot, and it saves vars, but reboot
> fails for whatever reason, you plug it in another machine ... and it
> tries to "continue" from there? The amount of validation needed and
> testing for failure modes across reboots sounds really painful.

I kind of stand by my other previous suggestion, though:

As a maybe less painful option, we could disable EFI runtime services
but have a root-writable thing in sysfs that (a) turns them back on
but (b) first extends a PCR to say that they're turned back on.

--Andy

