Return-Path: <linux-integrity+bounces-9880-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3a4uJU+aR2r4bwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9880-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:17:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF46701B9F
	for <lists+linux-integrity@lfdr.de>; Fri, 03 Jul 2026 13:17:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=WCXkxgpJ;
	dkim=pass header.d=redhat.com header.s=google header.b=luM+g1vl;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9880-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9880-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 97C6430058F9
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jul 2026 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C216B33B951;
	Fri,  3 Jul 2026 11:11:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88838E8A0
	for <linux-integrity@vger.kernel.org>; Fri,  3 Jul 2026 11:11:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077114; cv=pass; b=rcRsrTpUX2BuXtvwWkDK0yDSvg9pMJh6gJOl2sU1wfDYaAR9ApYg+Wx46LHywkNo/M1tJQ9wQV5ojPsokOFDPsAdc7ahns7/MH/LKEdCNiBt4sn264B3T0Zir7uj4EyL0wUmrSP0sPL501ijtADEPBb6wFp8aCT81/dqlAPmRrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077114; c=relaxed/simple;
	bh=JCgy0GaVc3z11BFwL0X3R12vVkyNJAAxfQevHyr9czY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k303IJstexgWVDhFP372ygdtSF+lJrTwvt8J8mLl4lWx+qKzSOxxVRI8znimlzn1qtsc2jD+zOsgmLvdRFYNUk/V9JY6UOGJacEvFQB0aOy4KfW0X26SH1eZXZHadrz1+ExbWoMs0d0zYHI3bapYfoLlryNBKJ7GIUc3ZShz480=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCXkxgpJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=luM+g1vl; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783077112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
	b=WCXkxgpJmt6DZIAM8CgzWvmtHblTDasHcV3776dJxBk6mnOG7yUGOBTCFq9+/B5W5JXt6+
	pHl0eQPq8DBDW8f0cslEbQ8qJwtJ8CpBCHrwfF2bqPGwc9ayEV5dae5KmlfLDATDCtDbGR
	HHZ+gsjPyGf9MMTo8uz55Ll5/7A7+mA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-QWYaU3soPzSPWdKwitDsmw-1; Fri, 03 Jul 2026 07:11:51 -0400
X-MC-Unique: QWYaU3soPzSPWdKwitDsmw-1
X-Mimecast-MFC-AGG-ID: QWYaU3soPzSPWdKwitDsmw_1783077111
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0199faafso5315691cf.3
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jul 2026 04:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077111; cv=none;
        d=google.com; s=arc-20260327;
        b=YpVwI62VCuBdciUt2p16ra7s23ERjSEPzdxud109LInofTRLKr6N6g0+izwAIJCK3w
         U22b40qpxLNeP1JckdCUxij33ry6mLrjWBV5pyYJOQTCuaScZb7UuP8OH/ddtnLk0coE
         eeValFuH0qgUk1Lq1RUmUdtEXyIZzwdoSDbvMwCsFqy6e70rBqbJjX9Cb7BgKmFEFHba
         mvmf6QDxBejfz6rpotczkhDhxZo+D5gbcaoEEE8rsu2oPnYdPipDvrEgmHyj2xHJz+4A
         fTkt3VWgAcm1VLOQOxaMAO3Djzqy6Be1NpTMo84tRRIpIPrCVWAU9yvBzmm6OcTH/vZi
         BQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
        fh=p7H7OxbvRg8WIVqSQMpVNmQr5kJecCE/mznMOQcSiG4=;
        b=WXtRVCXQiiCnDqppofBYGup5WUXeTVYeQvKFi/CxKCdYaOvbVBHqe4kvCVXkfd0qQ/
         x5iXKvDTzg8xEYCqfoeV8MnY4Ninx4TpYSYI7CFrGJyXstrTBEPpVHkyH5SIbeEx/kIE
         JUxxfMb9344x+cuZBTj5SRzVgo28g6h4O/8H+QTTpi9nxkohfjr0Xxm4hRh5g2JkDCgO
         4Xb+DTASOohjMAUUKgSi76lGPK0sDL79XNa00BKleVSImFmpbKRaF8KbTOPuQVt7+Uea
         o1+Frd4gDft3ge+Y8Y+/q+Wwlc0IX7HNHAqiedU6iESuR5xDw123ZYdununKwZ/EMOAf
         ru3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783077111; x=1783681911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
        b=luM+g1vls/Jv/+hOhENOxvBeW98XrI8loXpDi8FeO/CHxIgnUVpchuZRrT5T4xeCvt
         NS935rb4d5s2qcAZsZbCYZgFuPD+nFcpCPlKtBB42O8Fwopty2McfJMuEQo8Pp89ksMR
         +tofZLY3h/CLX/PresyITM9iNA4hu5FAsxZc3ZC/cSY/X/s5amZ78jOWthXzo2CY6Jqg
         Gmr9Y8ttEdvpVrs5DadUFGvwMqw5L9qlGRb77NrmA5PJZZx+7OijkRyHGtKjFcts3bTu
         c8qWz7xYfF1DeGjZwK7jE9qldCfg+Zv6rLZYnVlTgjsga91Pwrn8XdPrMcSqfR85CzJN
         XW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077111; x=1783681911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJa2AE/q6LxcAJlKRT9Ro3yKfffQf1xa1GooqwuD9kA=;
        b=T2qbQFx1hc5erbZrVAPmJ9689p2uobBPn3krBWqcF8c56K78czTnLgblMGjlKkVmh/
         MJfJsWvwCOfjzIlxWp8oonjI4wSdGgO0DdDE0r2ewFaNFf/mTZMWGN+b3X3md/4qo4ka
         4IAONRfEIOE/4fnKcrHGqsZ8O7P5r94ynMWgrh64iiEN2wDRbIHqlI++lghKG5z15QWS
         JvR7xhuFnl4RfWx4gQDVQc+rDuXg0hmqc1LbfnwLtBxG02SMXtoJvntKVxjp4t76/w9f
         2ynBG1lEoWNzYKyR4KA7g7NuXZZG1aeD4Cg/uVusvHu7xvveWS3IAaHPXTQvIFwEPxVd
         8CJw==
X-Forwarded-Encrypted: i=1; AFNElJ/b5XA2ffcyRChFpVbJNJjDcDoz0CxYAVOJDQroGOp8oghxXScVP28jV49Eme1VEZtFBqwLL1kc3Dd7otPzkBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23hFKraoZi7BhWCe36x7gZu3JBMAIW/o5wIbLdrXZkWZAnNhI
	3vvVulOid9jZWJRmigHEWQcFS6lbQy7PJZihQptIfsu+1aeS+lk0jteKwKoasz7WtRpaBWew8zN
	8uOwhp44EtVpn2Dz7xOg21n1cUuPqA2g5P+yS4CazJleVKxuyIibYOEJWdZHsq8dnPvhhqF4/Rm
	b1wnaFu2KFt1yJlFekDEUGtXA9JQ52EZ3sqXlwW5Jw/vi9aigs8Ycn1oE=
X-Gm-Gg: AfdE7clH116m0rO2Bd+O6owmKz0LgHOPNbudZ5T58L/ZUKCo6hADplCOl0sTC2v1q9h
	fK6TiXVZ9E87hMhk+kTmc7L7XnYsQJ4LMwrEp4zI7Tf8YdqxL62nbY5SoB/7GAOCbqxS917ufI+
	kLEY1mTf2lXQXqbOvPrdQiQfIamfRyTUFpccULN0EqeSPZMlPVa1K1goRMh7DQiQw+mA==
X-Received: by 2002:ac8:7d53:0:b0:519:e91a:f4bb with SMTP id d75a77b69052e-51c26a8f88cmr125087351cf.31.1783077110656;
        Fri, 03 Jul 2026 04:11:50 -0700 (PDT)
X-Received: by 2002:ac8:7d53:0:b0:519:e91a:f4bb with SMTP id
 d75a77b69052e-51c26a8f88cmr125086941cf.31.1783077110290; Fri, 03 Jul 2026
 04:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701025732.66330-2-ltao@redhat.com> <4b21e0d5-07d1-438b-a6ea-a2be596a3044@web.de>
In-Reply-To: <4b21e0d5-07d1-438b-a6ea-a2be596a3044@web.de>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 3 Jul 2026 23:11:11 +1200
X-Gm-Features: AVVi8Ce5GouoiHvVypy54hHJATfssSZf7IVivve4m9vb8B4fIq_nNJ7KXKAOoB8
Message-ID: <CAO7dBbW_vxnRiq9QrZK0+nuNUkzOG8qrqYhKqzrz3FdRcayVOw@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: Fix a NULL pointer dereference in machine_kexec_prepare
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-riscv@lists.infradead.org, kexec@lists.infradead.org, 
	linux-integrity@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Baoquan He <bhe@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9880-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	FORGED_SENDER(0.00)[ltao@redhat.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:Markus.Elfring@web.de,m:linux-riscv@lists.infradead.org,m:kexec@lists.infradead.org,m:linux-integrity@vger.kernel.org,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:palmer@dabbelt.com,m:pjw@kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bhe@redhat.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jarkko@kernel.org,m:zohar@linux.ibm.com,m:nutty.liu@hotmail.com,m:pratyush@kernel.org,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,eecs.berkeley.edu,ghiti.fr,dabbelt.com,kernel.org,redhat.com,gmail.com,oracle.com,linux.ibm.com,hotmail.com,huawei.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EF46701B9F

Hi Markus,

On Wed, Jul 1, 2026 at 6:01=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> =E2=80=A6
> > Fix this by simply adding a check before copy.
>
>                                            a data copy attempt?
>
>
>
> > Fixes: b7fb4d78a6ad ("RISC-V: use memcpy for kexec_file mode")
>
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc1#n34
>
>
> Would a summary phrase like =E2=80=9CPrevent null pointer dereference in =
machine_kexec_prepare()=E2=80=9D
> be nicer?

Agreed, I will improve it in v4. Thanks again for your guidance!

Thanks,
Tao Liu

>
> Regards,
> Markus
>


