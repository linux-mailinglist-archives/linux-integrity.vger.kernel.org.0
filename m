Return-Path: <linux-integrity+bounces-9885-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ds/2MxjxSmoDKAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9885-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 02:04:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5178870BCD2
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 02:04:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Jn0Y+VAb;
	dkim=pass header.d=redhat.com header.s=google header.b="nSM/ccMR";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9885-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9885-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DD2230068CE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2026 00:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ABA2F84F;
	Mon,  6 Jul 2026 00:04:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56817D6
	for <linux-integrity@vger.kernel.org>; Mon,  6 Jul 2026 00:04:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783296278; cv=pass; b=jO7oc1Skl1giUaDFI35CH5USww4znhgR050Tkx6VpW05lPDY2XUzq3q7C+P/N+GFamLbWRP7B5GZ7UY6kyYOCcHCFymPhmnUCbToZ8yAM8GEVL0bzFdONW06oC24MiH8pYK0CHGYPe3IyqE4cTmJbs80nm/J2r/EUO0IzCNTqOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783296278; c=relaxed/simple;
	bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOzQWiqcdMc/W9uCdzLJhqcjywRDDyKzjmN/z4AuTFl8lG42d/tP186ZFmV4Gfp/W80Vhhi7toNGaZ1ONTorNxP6DNnIcgOyP74IfGaHOYRVHyhbG1in4o2VKii4f3zEDTEZ6OG5/3mqXSIIRMjyInTxzwO5bhLUarDCkxMNc5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jn0Y+VAb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nSM/ccMR; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783296275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
	b=Jn0Y+VAb5jkUYChKoOKRnYfex9vKbmhkSYvNquLb+jjwpVfRbfMM5DiLMUv11nQN3p/6jV
	Vqu/6iZfNfFyAYhAYzmUrVRjxNRpyxHcDW6jmzfPCXo6mNnKAHc9farJmg0dT4UT2G/cpI
	8Pm74Iflaoun6v5q0IuttRXHwHr3AFM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-JIxuB1fXO5KOLTdNJ3ytGQ-1; Sun, 05 Jul 2026 20:04:34 -0400
X-MC-Unique: JIxuB1fXO5KOLTdNJ3ytGQ-1
X-Mimecast-MFC-AGG-ID: JIxuB1fXO5KOLTdNJ3ytGQ_1783296274
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ea24a2db9so130364785a.0
        for <linux-integrity@vger.kernel.org>; Sun, 05 Jul 2026 17:04:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783296274; cv=none;
        d=google.com; s=arc-20260327;
        b=ohPh6M9hCLfmKdmNpEakx0O4/EJlcN3h9dZ0xPvTEe9HI7+vtqZm4FpDgWstHnGdZ2
         sIaVc0AvD2s9WWwYAOoUmEU8P2RXFMumrwLKHRUR5M+6JOKB6V21x32EgNJJW0t1EvUq
         lRja7Hy2f/Pvzxe3M0JNCkEFOgtjP9EryrGvL8RhRhnvS7NZ3r0DkfeBOzcP7hX9at8D
         4I6IMjEgHnHIEsm+iSihTD8w2kEaLabTxDEBcM+8w8yyoSJVsWqZwREBtvMgQJWwGXVG
         d6h0tARpRA37L9pd3VFv1cYkALRDRxYo4LWoPeEjrYaojV0/mVayXKsUsLg1MKbPGoDj
         Yk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
        fh=dPNvXdaCzJPMJr4GkYw4GfrL1NFY2nkMG4tSwR61+Zk=;
        b=Wjp2MxVv+tuEG51XDnr9sToOWhJN5eCRLL9l6FgZ4ZzJgDBGi4FeasHrdH+F4sBvCO
         9er2ix3KVtCm+J9QCQ5DDB+gHexp05A+2xBJbgo0b8rrx6TVyfWxTzsxI2mw/7nHuh2x
         PFY4pKShyXuLp3I8eXaJNQf/SNpj+lr01Ngl8W4tNIr9/hB05ov3dfjgJM94bcwyLqUn
         TVGcwLhAFDp05Cba9+sqhcsjMR6FBNol7mvJytSlpL1kiRX80My28vAdAlMYY6+SDhvG
         BI60lRjwG+kAMC73HGT8Yys9ga7VxuRAoj+gmfBHDRxU8P8/C0vdapxAKuqwn65pc8q6
         3x3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783296274; x=1783901074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
        b=nSM/ccMRlN/nEvQmfagHh8MxAp+2SLL6zby8m7AEtO17BIZenwJRmOTPUlMcdCwXxE
         6D2XYCtqWAh+Cwz91s/WRgGFd8kL6TsZyZLfkL4Wyc73e6YLffB+fuMxA6Fs5khf0hsB
         EwxpSZRMPmBPu/WKaPbvUGGHk5aeJ5loUxQEvwBHnpDR3/4sirUCBxphadno+oOIJ6f+
         Mi+eDTWYuPryv74r4uvKH+UB9zBOh9ZoK2H9ziCGBvEEozmMhKIc4vqRlidKZtnHbNR2
         AiXoJ4RJvKHV0eyLzvFpiQEBBCQecmOw9sORofmoJn1Y4qyaCjxDL1vY3BlcIpKP9qnO
         cjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783296274; x=1783901074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gDia0DoYIpwPsuYDBJR9TVRq1ZkrfGuScKjEdDaH/ok=;
        b=CDAadz55fUhv6m6PS4l+zsu1/6ygSX0XrVxXsYNJy54FW7UBcb1fcT9wAucZ3sklA2
         ow0WQy4UaeZ+yTrs6RnQc/XsVooC0CyCvEfKootpCgsGroiYMEEzEwXtglMxwvgNzxD7
         uxIDBYytYtuP2VtUMkXzfmQWDRdEqrUl53NCsq1/pD+HP69le7jZrJaxp+xiD6WoLwhB
         ki4GCTd4tL/wNxBpPfijjNypC301zheXJtQqkuj54eoW47Xb1Kk4C0sbOVid7Q7HKbzj
         QvYzwCB3oB+2GYxjCj03+5ljowm17Umid8eN4pE5Oq1XOs9THJLibDL4bwbR4EEmwvDL
         pDVw==
X-Forwarded-Encrypted: i=1; AHgh+RpiD9TEZ03E7INUtBbrqiQRKSEZurb1PF3Z91QanAPSAdwLIDiiIeJX9QHWWeC6PZ/sQGw+yHhTHv9xjj6nw1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1OvFqs6FSG4SSeftVXBZl460q57mKHqZ1qA/F7VALkCsTRu0s
	E1alPT0ttWCP+RDbMvnfP7huqlbivEY+JSncxl32fQkwnZw+ckxD7JYrHvbwNQSuFCyzMOGmhAj
	0SYe95D8o7bDLLvCGEAbg9tNxIaXvG+DW7ExmHL8dAqi3IOzwcLpMirhvqkiKF2D6lnOcKk0yCI
	7Fvth/kBBZQx200gBUwYZlHFIN7qoa2QdeBawQ3vvdGneR
X-Gm-Gg: AfdE7ckuURREeBUSW/fMFI6Kbrk7myCgik5azKOPzGUzkaT9pJB5iYd9H5VOgUKn3Ms
	cFzZdT/eESOdYSKOlgG2ch9A9NZiX6bp2LCDNm7JzrEXGMUBvfuttwar9tGVrMiY7dMLlV3skVh
	1LXjLusBj/nHX5+9d0YbrkoasnnDHOS/EFKa49/bXiyyyVFePo6jYP
X-Received: by 2002:a05:622a:16:b0:517:580c:bcd3 with SMTP id d75a77b69052e-51c4c20cba0mr122057111cf.19.1783296273939;
        Sun, 05 Jul 2026 17:04:33 -0700 (PDT)
X-Received: by 2002:a05:622a:16:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-51c4c20cba0mr122056741cf.19.1783296273461; Sun, 05 Jul 2026
 17:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703111530.91285-2-ltao@redhat.com> <5df82d42-89cd-4e39-95a9-a0f164c0ac58@web.de>
 <2vxzqzlkf7a3.fsf@kernel.org>
In-Reply-To: <2vxzqzlkf7a3.fsf@kernel.org>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 6 Jul 2026 12:03:57 +1200
X-Gm-Features: AVVi8CcjKi4ma2Wic4NJ9zPTMxZKVqVzntIjTUPD2jSDdeylkQQJ6VcTIYGM5zI
Message-ID: <CAO7dBbVmLi8gWcntM9tn2g=GWgAkYQB1P7_-J1Kf8wYrd0Ucww@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Prevent NULL pointer dereference in machine_kexec_prepare
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, kernel-janitors@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9885-lists,linux-integrity=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pratyush@kernel.org,m:Markus.Elfring@web.de,m:linux-riscv@lists.infradead.org,m:kexec@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:palmer@dabbelt.com,m:pjw@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhe@redhat.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:nutty.liu@hotmail.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[web.de,lists.infradead.org,vger.kernel.org,eecs.berkeley.edu,ghiti.fr,dabbelt.com,kernel.org,redhat.com,gmail.com,oracle.com,linux.ibm.com,hotmail.com,huawei.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5178870BCD2

Hi Pratyush & Markus,

On Sat, Jul 4, 2026 at 2:59=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Fri, Jul 03 2026, Markus Elfring wrote:
>
> >> A NULL pointer dereference issue is noticed in riscv's machine_kexec_p=
repare(),
> >> where image->segment[i].buf might be NULL and copied unchecked.
> > =E2=80=A6
> >
> > Would it be helpful to append parentheses to a function name also in th=
e summary phrase?
> >
> > Why was such a hint not be taken into account from a previous suggestio=
n?
>
> Oh come on, this is a really really minor nitpick. The fact that
> machine_kexec_prepare is a function is fairly obvious when reading the
> patch. In fact, the first sentence of the commit message uses the
> parentheses.
>
> So yes, it would have been nice to have them in the subject. But no,
> this is not at all worth anyone's time to fix. Certainly not at all
> worth a v5.
>
> Please, let's not nitpick our contributors into giving up.
>

Thanks for the review and for pointing out the issues in my patch.

I'm still new to kernel patch submission and clearly have a lot to
learn. I appreciate all the feedback. Thanks again for your patience
and guidance.

Thanks,
Tao Liu

> --
> Regards,
> Pratyush Yadav
>


