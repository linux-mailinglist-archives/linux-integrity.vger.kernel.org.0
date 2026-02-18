Return-Path: <linux-integrity+bounces-8511-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gImnK0oilmnYawIAu9opvQ
	(envelope-from <linux-integrity+bounces-8511-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 21:34:18 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD7159764
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 21:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49DF73024102
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Feb 2026 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F6F345CC0;
	Wed, 18 Feb 2026 20:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="Z4MERPRO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8A3168F7
	for <linux-integrity@vger.kernel.org>; Wed, 18 Feb 2026 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446855; cv=pass; b=YJxua82GeCMoHPM88rd2rR2TY/gfSbJeZpALWIMb8cVGdsuW/dT0bpTdRrfC/xD8AYohpHxROsMWTr5s8f6ilPtqICMuSGoVQszksbIsAt5iE6AacnpX8itBOWwLCHUjqCcVETY5Kul7MQKrJ8DGk7P7RxH6lpLwekPaHJ1xd9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446855; c=relaxed/simple;
	bh=7C5a/FWuVnB5cGwTAOV2Br2wE+JlZH1M0yzztc2OQnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNss5VHtDkcLWQXZJVCfzpVy9IgxRehbvH1Ix/bgM0SjXPG/xOEyctdGIY/P4Q99ipfE0Bpk6IOpcb2c2DAPkC2k0GWkf6LWreMzI1nGBbqpsGCd3vec8K7CXP6C/AGvkwFq77+ItBKBhgaBnmseEtIVxfqV1E2EPGQziBHdJoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=Z4MERPRO; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so260153e87.2
        for <linux-integrity@vger.kernel.org>; Wed, 18 Feb 2026 12:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771446852; cv=none;
        d=google.com; s=arc-20240605;
        b=SaoEHxLv2y85pyVCh8NXwQzaRFTiJZwAsFNO0V1Yp1BIN2eWgm8JPLaivSzH+chIgb
         yPQ6ilqtffl90/CcYNE4u7JlPK55KVWEB3YoB3EFBWqaFLHziVRd6+MCBZ71a9wUEJxw
         Rex6WGjKfOqp5XY+0dbl0fPnN5GJJ3PVgRRu3pMb2F+t/4WnzMNREkNvLglLoDUvGzQZ
         XRfG7yz33FgMMRGYiWAmoB6PcKnZy8A4JR5mGlZgoVo6W+xxRdozDklruRMzOFX7a8eb
         cQa4BvTGLFRy5xyow9JnZJ3TbMxd9ZwcOqCvzmNYhuh7Rv2mZPylSnbXQxJCnIk8Gg3g
         1w3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        fh=Adow8jC9UYBZIedg5QhVYc57+n7u0rEIpksecCBKkjY=;
        b=FQ/UhK8xw5/6g0RFJwnHUNSi6rVhZZq6x3QWJhfVAC6i+548wma0iuTn2iGVcCmUNY
         bfXnbQLeWO/VP45noJKKvB2OhFsfNqc2WNkbyc4UHzZL+aKAgkza8sSUrhMwe6pUzZAE
         V43LgbPaJpxbDTJMj0+KMWkA3BIbciuzUR3lhAThzp+nM6fzK4azZq8bkQrQVfl9PwvM
         KKzxg4Nq9VsTaLpEzQ1rbSXDjF1cxpLa7lBXlJgsGOPl4wX/cxW+y2a1sfDMBtswiH0q
         yaSACbyNIna3znXg4mzK/q20rKblL8yIV3l7RAp9omDoMBGdfASZl0cWXpVmexCSCUyF
         eAqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771446852; x=1772051652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=Z4MERPROgc9FSVfsG/kG3t98pIsPZiZa2ci+uYC8QxNYZkIennmepWfaiy7Su18KK4
         XL22ZPuUBe0n4IDEa5pCurRylazjGAVX1OmmoNEjfSxpevk9PQUIMFk5G6kXLbqdjiOO
         fqYt3arXfK+vc7SaJ/DL7BwDklV9pbrB8HHrXjb+oweXnLTx4Cdk5LXocPhK7369V3HC
         aBoWerMPnojZBqm+P7TfDpbyBsNBRPoofMPIJsdtWxi+ymZYmqEnYt2BJKtIS6s8nGkP
         h+gbveSCj6t3jiYDKFzSlZTqUuiFL/tNzrF6CYvIzH75E4v/8g0KMg91glEciuzyaGGt
         Ltkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771446852; x=1772051652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AtdZqt2ARoYJJMPe919rNdJ3JohEndwFbHKNaMS4Pw=;
        b=UO+4X3g8jnQipycaAxXZMLaMKwrHQ5Y8G7ZRTC/pSevhaC0Irri9DP6oGNT3HFX4Pv
         6O663eImgO8asZg+sp+dgL4gBroyzNgWrJuhjvtP2byInnV2nC6FhsXZe7wyLBdTTva8
         eZQUl+QCHR4LESF+DPwLYlAYk+rmamrwwS+XLk1Ip+co9UPoeLOnjnpelUgw7KF7d5DY
         YyhXNHiMINF+XN8F+m5P1Nn9r5/zklTbfNI+Kiu8fIw0jfInMaXBnHQNH5G0Gvavg0ds
         7k9co6tyIf8eEfrcqb1oCYzmv60Ks0hCRsLWqaYuXoub3+QPJ5YGUY7zqDxSy81nUFm3
         BrXw==
X-Forwarded-Encrypted: i=1; AJvYcCVa9OiApAnGI/RJ9uhJNe5T2XFSLtvXq7XEPFZ1Ut0gVDeA9TMG/UG2MuGKAFF1A6I+wfSXIOtuxLRE8jGtRSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzBzw53x9m5pxBNFn8HTba49xlVJequmxnV/3+6YukUsrlq/48
	bkWTlAC0GOw/nll1aUsQVPkcl7BO3S7ROz2zGPV1UFFvupibdiRwsrf0PmbDDqwZ7hwlw4/Dp4Q
	FDZd7z3SjCdWda94g+uTnmTQtd07kAZtuZ/VmLY+E
X-Gm-Gg: AZuq6aK2by253O8i9hQ3GZzAhCAx3yFqD8yqAYqzsi6jyMexNbXylqMHzT9gCbX7ZWM
	QFPC9ZtJJk3hXbDWIBYQvEkS1wP1f1j/dFlVJAXqmX2zMGBR+pen4Ugo/ND1tVtkGznwp2XIOk0
	2rv0G8LfGflKHOWfiJVtV3DTXbbbz3Y1r3zFDXQ2EHwjHI8bHdbEhT22qVLPMIniypX8+7efEUO
	9JJL80JnSJH6WEpKyG2M3/V4FQeYcb04K8j8XXQPbA9WNsbk58eRZtQszQdfYvPTEhHJMo84FFk
	dfxH
X-Received: by 2002:a05:6512:1284:b0:59e:63b7:585e with SMTP id
 2adb3069b0e04-59f69c68122mr5099221e87.36.1771446852112; Wed, 18 Feb 2026
 12:34:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
In-Reply-To: <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Feb 2026 12:34:00 -0800
X-Gm-Features: AaiRm52O5CUthtEuekouveR3oQDy41lsj_ZjT1TsYC4xSgI6Vkc6OZxoV-XcGok
Message-ID: <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
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
	R_DKIM_ALLOW(-0.20)[amacapital-net.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8511-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,apertussolutions.com,oracle.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital-net.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:email,zytor.com:email,tandasat.github.io:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1ACD7159764
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> wro=
te:
>
> On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
> >On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> >>
> >> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> ...
> >> >> Surprisingly, even when doing a secure launch, the EFI runtime serv=
ices still work happily, which means (AIUI) that code that was excluded fro=
m the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RT=
M entirely in the case some exploit is hidden in the EFI runtime code? Shou=
ld we measure the contents of EfiRuntimeServicesCode regions too?
> >> >
> >> > Yes, in fact in the early days I specifically stated that we should
> >> > provide for the ability to measure the RS blocks. Particularly if yo=
u
> >> > are not in an environment where you can isolate the calls to RS from=
 the
> >> > TCB. While the RS can pose runtime corruption risks, the larger conc=
ern
> >> > is integrating the D-RTM validation of the Intel System Resources
> >> > Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the In=
tel
> >> > System Security Report (ISSR). Within the ISSR is a list of memory
> >> > regions which the SMM Policy Shim (SPS) restricts a SMI handler's ac=
cess
> >> > when running. This allows a kernel to restrict what access a SMI han=
dler
> >> > are able to reach, thus allowing them to be removed from the TCB whe=
n
> >> > the appropriate guards are put in place.
> >> >
> >> > If you are interested in understanding these further, Satoshi Tanda =
has
> >> > probably the best technical explanation without Intel market speak.
> >> >
> >> > ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> >> > ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
> >> >
> >>
> >> Thanks, I'll take a look at those.
> >>
> >> But would it be better to disable the runtime services by default when=
 doing a secure launch? PREEMPT_RT already does the same.
> >
> >So I have a possible way to disable EFI runtime service without losing
> >the ability to write EFI vars.  We come up with a simple file format
> >to store deferred EFI var updates and we come up with a place to put
> >it so that we find it early-ish in boot the next time around.  (This
> >could be done via integration with systemd-boot or shim some other
> >boot loader or it could actually be part of the kernel.)  And then,
> >instead of writing variables directly, we write them to the deferred
> >list and then update them on reboot (before TXT launch, etc).  [0]
> >This would be a distincly nontrivial project and would not work for
> >all configurations.
> >
> >As a maybe less painful option, we could disable EFI runtime services
> >but have a root-writable thing in sysfs that (a) turns them back on
> >but (b) first extends a PCR to say that they're turned back on.
> >
> >(Or someone could try running runtime services at CPL3...)
> >
> >[0] I have thought for years that Intel and AMD should do this on
> >their end, too.  Keep the sensitive part of SMI flash entirely locked
> >after boot and, instead of using magic SMM stuff to validate that
> >write attempts have the appropriate permissions and signatures, queue
> >them up as deferred upates and validate the signatures on the next
> >boot before locking flash.
> >
>
> *If* a physical EFI partition exists there is a lot to be said for this a=
pproach.
>
> The only issue with this that I can see is for things like network or CD/=
DVD booting where there isn't necessarily any EFI boot partition, it might =
not be writable, or it might not be persistent (e.g. http booting typically=
 uses a ramdisk, like the old Linux initrd.)

Hmm, I guess my approach is a 100% complete nonstarter for installing
Linux from a CD, and it's really not awesome for installing Linux from
a USB stick.

