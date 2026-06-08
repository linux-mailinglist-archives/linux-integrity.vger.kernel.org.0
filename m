Return-Path: <linux-integrity+bounces-9777-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YUKJKDn7JmqYpAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9777-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:26:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BF659378
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:26:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=paul-moore.com header.s=google header.b=UjdtuYRP;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9777-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9777-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=paul-moore.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C9E53045B4E
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414C34104B;
	Mon,  8 Jun 2026 17:24:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0473D8107
	for <linux-integrity@vger.kernel.org>; Mon,  8 Jun 2026 17:24:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939494; cv=pass; b=mGprgnJP31pVnWb2VkVmTsa8ed+nJqRloBzmqatEn9bYf833SQyhc3vU7Kq7ga86HzYuaVUEduoCuqsOWqOyelKXFCTcSfLw6HyQJh3Qh8eiH89UYTSvhq2VBvEoUalYh33znog/gilbg1DT2DLaByYFIAGh4ykzZS5NetfVmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939494; c=relaxed/simple;
	bh=7Kdsfq3M6NlEdFS2bnCUaBu5hUrHR4J7G1t7KNXfpvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9b5UQaCoeQ7OTcJFe7sQzRLssmYXkk/EziaTK/iPeb1sIHvZenhaTWgcoPESNtCdVbzkuM3qYbQXpqHGYjr/Hza04v1kmh1TOjfhdjGnyDI3YBQ2jwJlDobL/ykuTxWY1VKyBXkrhv9NLO0y4Bb6kxeGXvP/gZJbb81UjBar4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UjdtuYRP; arc=pass smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c2a68d01so31347675ad.1
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jun 2026 10:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780939493; cv=none;
        d=google.com; s=arc-20240605;
        b=BpuSQ0AKJh0drNZPO2497GWwSKMmoNbU3PYSWidNWQRUiXUHB2m6l4SGgc/8imFvnk
         EnFQvgYqSUDoG0jmyrR1cSeIGVvn/ATrJDXJI5z7fcIGM08YlCIQWWknzGg9uEX3tt8V
         MKbzGZoMVWLUHxmAIhcOeWiwn0BGXcQd4bxUB1KR6RR8ux2XwYt67HcSZBFK21+6x7an
         IXYdzr96wM4yBf0vNIHfVpjltksasZsjr7JKR0NH9+q5Bcl9nEhFifcTrzp92BTUHjCN
         0/oVCdvm4SFoRHQGikY4hqtcMVedv8RoegGks1ZQhn3J37FELdOTsNZeqlC+TQAgLHX/
         ET6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        fh=zMHkuDWfRmnE2/wiPY7InwCVFMvXw66G+ACxbO6InKw=;
        b=MbL4Eeg6ylpcGSzEkUbR9RC6PI5IsGNxPXZrr4riBlDEq03vy0P+SEiPfWpHUelbGO
         kPbSdEav7ahjWpxA5b+Qfm+oG3zdsd+zrM1CP9V7hzGKCxQr4tRtHmLOQTbdaaW5+B41
         zPe+SdE9os0xKxcBNbh70fwCsCkFeEkZVKB34kXXi02QQlfI31zm0L+aCnAStVy1UlAv
         bKYfjLmDpW4lbxKZKx1eST0mAoqWhjdDOBTYO1y6+rhpnHT3gowaBwJxH3+Lihu3ULl5
         rPWhOqHNFlVzieXzMTB6wvJImNVhbJYVoFnoq1992faHaZjs+nNvWHmOeKLPU5lW93yT
         Wa/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780939493; x=1781544293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        b=UjdtuYRPGjEVXBKOpyPMtogry1A7fN8YZtfbTK0gMFZyn052WbGsC1pBoKedD7hRXy
         WQe1hi3y2V+lYX/brFW3Q3036PAvrM8VGaWqWeYNhedRyX2JaHVm/iBlrNX4vCrDDo1J
         A298VqNwayOkk/IyTcOW4e8D0szLstksa3Qwhx4Q1AJ0nBGr4V0E4ZOOTSfMmckA7fiS
         bOJ8CDik94EWq6aaUjjcR2i8vToW4eEIN/sCP6fHLH1/3JKJh0b792s26XjVgFyLvLrn
         nNbjYXCVkGOQesztAdcYDYUF5f+DjDs1hPghtp8F9ZEbSxTq8Csez3nIGfKhO/2etamo
         Vd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780939493; x=1781544293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8JBElMQXP5d/TECdOlZtQLDN+V90z369cEJsD7o/qY=;
        b=LTpGNoiMGAtwLS65+IXUtL6596REeTqD6GU2UEWPbaePcfQisyAT/TZtJ7d9vqBBl5
         2ccYc48ZnZintyyGciAMj9e96KMtCX5btNdB2+24YjFufTZiiIIgiOrdEnsM7cmabOMd
         COBtsDpDVRKjoJ8WfSPYOge+xn1/cacVe+CCSWhG5SW/QzsodKeXwnWpSUHnUxMVErWG
         Uhex1KS/zK6gUYHX+gg+0OzRQYINPyUqjjldogyp5LFrTW+FdBzK6EJiazu6sdwAecRm
         /2nuCtIZBHfMBRr0mtl6R5EshA4jsUur1Ea0khgw42p4RvEgJS/3fcPf/3DCKiXMySVJ
         lAIg==
X-Forwarded-Encrypted: i=1; AFNElJ/C1vEYUE0D6yitKt37YpxTFXPiBbMMwwcLXS6rZ9v47No3frOtEzSbt6voc76NBmPPfFitrC8vSBpChYnHnH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdmFHKt0TIyxp/LsZK/5K3RAxbQKwSu1kOt6bS+ZfAUly1fHRa
	rTZUl0mBCPEmm8LhIqtHmXsZ5p3bONwVs39orFlnhiXsG0KAcwlmZXAQ/ZNnPfX9IqVdS/hHWJ3
	GqQ00T6CkcHfYo4/14cwCnspipFRaQmPxVsoEy7u8
X-Gm-Gg: Acq92OFt8lnFgtLHP/G+7Osp+1zOyUQLB5JtK76cHxygpQnFfBHBSFyhKDBQGRydDi2
	/9oP9AOUbTjCbB2DomaLIlJuylSyTgVIdrk+YC0VJcyvC8B01qYCx49dHmAJUUDVix1+vXDqZjv
	4j5a+tq/RHHW5HLjlsFaJFaF+uPimH8HbvX3rd9pnJeJ98iRzzONhOxIEggyut2olf25KSzoUHz
	RfRCJzLtzJ+8AM4qXmcF8F4UfR+HCGU4NKf3ItrPmeR4cKg/eGMsgMV96PlnFs1vmPegO0elVYq
	4J7QZ8pHPqfGSAqFezqqb5teTNVC
X-Received: by 2002:a17:902:e88f:b0:2b0:b016:773f with SMTP id
 d9443c01a7336-2c1e7d3dba7mr185086165ad.11.1780939492837; Mon, 08 Jun 2026
 10:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605144325.434436-1-yeoreum.yun@arm.com> <20260605144325.434436-2-yeoreum.yun@arm.com>
 <9b499a2a3101cadcfdcd6fc32289f54df10fea80.camel@linux.ibm.com>
In-Reply-To: <9b499a2a3101cadcfdcd6fc32289f54df10fea80.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Jun 2026 13:24:40 -0400
X-Gm-Features: AVVi8Cc6U7pcPpqOawvLTIEb90w3WN1G1z-dXh4nwGP7pqUP53pA_Sp10Oyc5n4
Message-ID: <CAHC9VhTN5xwBb6QFKeon-X1Px3AWesvPeyBEbebVQt1FLbtCdQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] security: lsm: allow LSMs to register for
 late_initcall_sync init
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	roberto.sassu@huaweicloud.com, noodles@earth.li, jarkko@kernel.org, 
	sudeep.holla@kernel.org, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zohar@linux.ibm.com,m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:jarkko@kernel.org,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9777-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,vger.kernel.org,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,paul-moore.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A1BF659378

On Mon, Jun 8, 2026 at 12:52=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2026-06-05 at 15:43 +0100, Yeoreum Yun wrote:
> > There are situations where LSMs have dependencies that might mean they
> > want to be initialised later in the boot process, to ensure those
> > dependencies are available. In particular there are some TPM setups (Ar=
m
> > FF-A devices, SPI attached TPMs) required by IMA which are not
> > guaranteed to be initialised for regular initcall_late.
> >
> > Add an initcall_late_sync option that can be used in these situations.
> >
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>
> Cc: Paul Moore <paul@paul-moore.com>
>
> Jarkko has already queued 4/4.  Paul, can we get an Ack from you?

It's in my queue, but with the merge window opening next week, this is
definitely not suitable for the upcoming merge window, so it's not
near the top of my review list.

--=20
paul-moore.com

