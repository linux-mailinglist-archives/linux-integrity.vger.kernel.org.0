Return-Path: <linux-integrity+bounces-6372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A64EAACF26C
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E2A17A753
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jun 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB38198E91;
	Thu,  5 Jun 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StUukNQL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296AC19047F
	for <linux-integrity@vger.kernel.org>; Thu,  5 Jun 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135368; cv=none; b=SpTWhDJvzXGmNitslVm3QDYoAz2N3x6+xoyb1iCL8CgqlBL5JM9EqWyif1iA10UKLp42J2VAMY0snSXY9t7MpDwQ0LY9F2BusnuQF0gUFbDaTOOejX0109N6XTTXiWuvMBQEiYPyzRaZTaqBbr668et/em/3LnkNPTsK2o5ryDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135368; c=relaxed/simple;
	bh=DHu18rmA0sU7oZNUXhtODTBETFCDhL2OEUU38uuVFxI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gD2SRW0I90JJNyBnYhjOHHgS/4vrCXW81rRHGVnG6oXXsuAb3T5QYvTaozzqp2zwm3W3snm93+BlofA+Ybx7MnZnx4WUXENcPHD2P8B5E1y92/tZy4fUftY9CCmeuShWWusMh6LcTpcMkwrqGUXx4yWlB6xb2KNOoRD61KvBGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=StUukNQL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749135365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFA6j3WG2u6wCRFKF+JPzUGEfqC8djtrecvjhVi86Lo=;
	b=StUukNQL108Y6Evi54eeZAqEf18d4Ah++jZclxB90nls9Cx2LO3Id54Q5fpM1Abt8KkR3g
	xIHgdK7RIc94+17ieDu9KEyfwS+qP5SFsOFP5P2JQ66yOz4fjEcXd/E63sXh6J4NoWV17J
	4kFE72t9uhzrHdicn+pCWUxkUEHEivc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5KLLA1eFMva5t2-5FvzZqA-1; Thu, 05 Jun 2025 10:56:04 -0400
X-MC-Unique: 5KLLA1eFMva5t2-5FvzZqA-1
X-Mimecast-MFC-AGG-ID: 5KLLA1eFMva5t2-5FvzZqA_1749135363
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso871772f8f.0
        for <linux-integrity@vger.kernel.org>; Thu, 05 Jun 2025 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135363; x=1749740163;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFA6j3WG2u6wCRFKF+JPzUGEfqC8djtrecvjhVi86Lo=;
        b=dVlLIBG9Z4FpQAGJlT4i73bBN6CfWMspM8s0NHYVF74kKMraQKRsAtmMRX/bHMY0ta
         C0bHIOYmEmvCqTtZ9NrNBD2rG6DYsxqzMQ4yxBLM5e4KmvWVndr8BtoQ6Kazx5iisNqz
         AhvgueH20g70eUJ99NxCvhmplSat1nlfzTs+13g/5K85Xmm8B4bX8xAJTMC9ktZzoCIH
         I7QASQYipqh/qryVODJItalk/fJeeQPkCA8ZKgsts0S3T/yPm5UMLsOu5jwnamwFLgv0
         dSWc74m1T6F5ODD68HRohr/H6+ePF6IKG7jhkdeOt4MPwM/n9PEKT3Ou1sH965wgq5r8
         svhg==
X-Forwarded-Encrypted: i=1; AJvYcCXnlt6lHcIEr2/RYA/1RvU0bPg79jf9lSppC/CjAdSzS47Gq5DvDnssXcVqcBiM1GNQi5YR4DffL7dmxd0JeBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHj+oAvRxPYwUgr4He9DhcjQRWMfU6c35jQ/mY4KsfHtmDXXjr
	lvz2fQFJgVjMoAFWpQtV0mDBPzbC3iduajKU/n94SU17qpXRxMaMeSwgK8l9ZjhzoawyBDnlJUB
	WbZ5oIj14P3C+Rqc6NPCrf5m+EB5a7bky5HqZ0fxIstViMhfU/dEBILkLFrDuYzG+3jSW6Q==
X-Gm-Gg: ASbGncsttdatj/OYJ0+2SvViK9NzjdkpmnCIg24D3BYQqGQOBvHtNnMfanCQxN2x7am
	E9yFGa7VW3qi4FzyrpDabMWxTgjCZHXtJ4ZLSm32BuW0PY8wc1YCHQRWsv656qCfzbhKpe3Mi2J
	9H9Xj1AQkJVK3+Iuc2HXO/arRou5QhsRzjbZaO+ITe2n31ubclFDeSZupSeiyhpEuOkXKS1ge7I
	e8aSRPS7bIYrBXxtjfmCB131DcEO8AlXA1hKlvNGm73ScTZzDUq0WYgrk97wqkohLTHyEYHEF5T
	DLh8G1I=
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061241f8f.32.1749135362782;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA81c6wZglVzh0Z3/rZiV4JQo/XmLeKsTiTnUWO5wj0USvJJ+iJpt9siQ/hlalGpRgG5o3Zw==
X-Received: by 2002:adf:e38c:0:b0:3a5:2670:e220 with SMTP id ffacd0b85a97d-3a52670e28dmr3061215f8f.32.1749135362368;
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm27314005e9.23.2025.06.05.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:56:02 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "linux-modules@vger.kernel.org"
 <linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, David Howells <dhowells@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Peter Jones <pjones@redhat.com>, Robert
 Holmes <robeholmes@gmail.com>, Jeremy Cline <jcline@redhat.com>, Coiby Xu
 <coxu@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH RFC 0/1] module: Optionally use .platform keyring for
 signatures verification
In-Reply-To: <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
References: <20250602132535.897944-1-vkuznets@redhat.com>
 <0FD18D05-6114-4A25-BD77-C32C1D706CC3@oracle.com>
 <f0b37bc55ed3c02569c74f0fbdb6afa8efd329e2.camel@HansenPartnership.com>
 <87zfemoc76.fsf@redhat.com>
 <435F53C6-DC08-49CA-AA36-9747FC1B50DF@oracle.com>
Date: Thu, 05 Jun 2025 16:56:00 +0200
Message-ID: <87qzzynsov.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Snowberg <eric.snowberg@oracle.com> writes:

>> On Jun 5, 2025, at 1:54=E2=80=AFAM, Vitaly Kuznetsov <vkuznets@redhat.co=
m> wrote:
>>=20
>> 'certwrapper' offers _a_ solution which is great. It may, however, not
>> be very convenient to use when a user wants to re-use the same OS image
>> (e.g. provided by the distro vendor) for various different use-cases as
>> proper 'certwrapper' binary needs to be placed on the ESP (and thus
>> we'll end up with a bunch of images instead of one). 'db' is different
>> because it normally lives outside of the OS disk so it is possible to
>> register the exact same OS image with different properties (e.g. with
>> and without a custom cert which allows to load third party modules).
>
> Could you please provide more details? The kernel module is signed with=20
> a specific key. The =E2=80=98db=E2=80=99  key in the cloud image must mat=
ch whatever key=20
> was used to sign the kernel module.
>
> Why can=E2=80=99t the RPM package that contains the kernel module also in=
clude=20
> the required =E2=80=98certwrapper=E2=80=99?  When the RPM is installed, t=
he appropriate=20
> =E2=80=98certwrapper=E2=80=99 is placed on the ESP.  There can be any num=
ber of 'certwrappers'=20
> in the ESP. Doesn=E2=80=99t this solution address the issue?

I think it does but let me elaborate on where I believe some (minor?)
inconvenience comes from.

We have various actors here:
1) The OS image which is coming from a distro vendor.

2) The user, which takes the OS image and registers it with specific
properties (including 'db') with various infrastructures (e.g. different
clouds).

3) A third party kmod vendor which produces a module compatible with the
OS version. The module may only make sense for certain VMs on certain
clouds.

The customization of the VM normally happens upon first boot: a generic
image from the OS vendor (1) boots and then some provisioning agent
(cloud-init, WALA,...) takes over and e.g. installs additional
stuff. This additional stuff may include third party kmods from (3).

The 'certwrapper' must carry the key which the third party vendor (3) uses
and it must be signed by a key which the user (2) put to the 'db'. If we
want to have the 'certwrapper' shipped inside the same RPM as the kernel
module, it will be signed by the same third party vendor (3). While this
looks a bit weird ('self-signed certwrapper'), I don't see why this
can't work.=20

Besides the need to teach (3) how to build certwrappers, an inconvenience
in this scheme comes from the fact that to activate a 'certwrapper'
which we install from a custom rpm, we need a reboot. Cloud instances
often back burstable workloads and this can be seen as annoyance.

--=20
Vitaly


