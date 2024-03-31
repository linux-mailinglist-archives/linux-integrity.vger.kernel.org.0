Return-Path: <linux-integrity+bounces-1945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BAA893528
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829DE1C219E4
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673F155752;
	Sun, 31 Mar 2024 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=system.is header.i=@system.is header.b="bJUtstqf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50606155756
	for <linux-integrity@vger.kernel.org>; Sun, 31 Mar 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903957; cv=none; b=JaGMsUnHPXItkWHEpmY7VS+8hg/EO5o8LDjnRWw998b3u6/g9cnYGnZDxK1Xthe6q2mEnS7+XmXnyqKFNwzUiU7Xylf0WPdodpg7NgB5kbdIGsq/GmIoFgYwTtEDjUtJmIs6xuyCY8bQ2ZMoaMtnLle17jG0Db9ju4x4mbecJZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903957; c=relaxed/simple;
	bh=IeW8nXVPnzxgqK88NSwhZ1MJ2HgusrIqdko5GfZ4lWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G//4J3Do1VdkqcRp9lJSvN/zGxFINJJ/7wFVaFo2sNyPcQXI4OmAXBVM5sdXX7oDIyMa2QcI2MlSxK8lppbg0J/StEmGZCzhuwNixUjGP9YkPDwdbnVsIBngbcKHmm+bMESv2PihdanSoICvm6s7e+Sl3oqTqJhN7xIwVneZRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=system.is; spf=pass smtp.mailfrom=system.is; dkim=pass (1024-bit key) header.d=system.is header.i=@system.is header.b=bJUtstqf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=system.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=system.is
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41564adfd5dso1277395e9.1
        for <linux-integrity@vger.kernel.org>; Sun, 31 Mar 2024 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=system.is; s=google; t=1711903953; x=1712508753; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QHk6V1OXbUlxmIghRS2wiMzfAWnSUmojluBqigCZ3CE=;
        b=bJUtstqf0l2icLQs4t/KQ4+r14ojjdxX3OczGwi5mY4fDSzR5CEIQv5ecmRFxi2PUe
         VR3TYFIx02CTEl7zPB5Q7eUCVr06il9/pRW/euJH9CzeyUub24f2eqUt+Ob2aBUxAFvW
         A3MG7H1y/nKX0yviZ/Fh0PwE6KkYi1SaKxPnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711903953; x=1712508753;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHk6V1OXbUlxmIghRS2wiMzfAWnSUmojluBqigCZ3CE=;
        b=Suxxs5NuhEO87mP9YDmrSClfiIeEtpmnhv1/wXKAuk7F8rA93p6ev4enl/6FHAQCSF
         zEcAqIjCMgVr/If8id6Lb/wwmXc4wV85ivO2U3fWbCerdQ6/gCjHRlYU+oXWslkE/u0i
         RKiRTZ9kefVMo0rjcFKaZb0Jo5ej1fSXEw/HnE02n5+1HDAh/JAdTVYHRkhZMmj8s5wp
         VhlUXVeIUl02SMN7oyewH69NdyiLyDKaGVF/FQfj6hzuCSt5aPt9Pd9d5utKzhKrZ0VF
         iRwZP0OghNoHJqG0lEUEZCOxxjirW+1Qer8cdDxTUUY1Mv0ZT8cDYH69aPbd24e2VrmS
         DcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUecPriTnAQgldhOiD7a0IgkwFw0VtjFbVLhCXpVq2EGQkYKRial4OFL1YM5UP3J3wu4i59eRwxdC3QsR7PUeABbHdhrfj17vZ95E/kpqBA
X-Gm-Message-State: AOJu0YwN9FXqwfrOmWNU6nXYhqDV+LxAut0S0H+FuJ2ZUIfzEL9kdaQf
	BTZAN3fMtAKpBPe78y6yQIaICjQHkAFC6RlsTDSLAhILoETOVPW4R4tOMPOHz6w=
X-Google-Smtp-Source: AGHT+IFMxwpkt3keT2j15Ez0qjDsRLTBg1hGupHoMbdlvBfl00jjNhGYSXvT8o+OGsN+zNeOOLm+Xg==
X-Received: by 2002:a05:600c:4f4b:b0:414:8e02:e435 with SMTP id m11-20020a05600c4f4b00b004148e02e435mr4905197wmq.3.1711903953433;
        Sun, 31 Mar 2024 09:52:33 -0700 (PDT)
Received: from [89.17.157.224] (224-157-17-89.fiber.hringdu.is. [89.17.157.224])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b0041562a58b75sm1781230wms.13.2024.03.31.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 09:52:33 -0700 (PDT)
Message-ID: <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: =?ISO-8859-1?Q?Gabr=EDel_Arth=FAr_?= =?ISO-8859-1?Q?P=E9tursson?=
	 <gabriel@system.is>
To: Jarkko Sakkinen <jarkko@kernel.org>, James Bottomley
	 <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 31 Mar 2024 16:52:31 +0000
In-Reply-To: <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
	 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
	 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
Autocrypt: addr=gabriel@system.is; prefer-encrypt=mutual; keydata=LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptUUlOQkZtUWRjOEJFQUMwWFNNT2l6Z2xsWVUxVFVpS3Y1WDNMQjVuc3JJMythVU5DTmFGTC9PdWtjU3VONitPCmNYQU1Ec1QyS3NuczF6dGVCWmhyYXVYWnc4dWFWWmpNSkRUbmE5cHoxbTM5YkFBTTZmek9aQ01BWWU0bU9VamYKemJqajV3ZlFvVXNaMDF1ekxNeUJUY0Q2SVVFRmY1QzVLU0N6TElSM0g2alp3ZDR0Z3k3dFcyb1FLL2dxOENESQpxUmVVamdmblNEeStuTElJc3ZxL3dFNFRBL0I5MFd5azlrcDVKdEM3UXRDQjhiaGN5TmVCQTcrVXVWVjhSMU9OCno3VXZyOGFnN0RiMmRTVEdTVVdQRi9Qckw5SXM3WTFBTU1FeUMxMEY4SGNTUUo3K3FhdkJ2Q3ZuVCtOUEs2V04KWmF2Q0hqU2FMditlTUFpZGcySXZCM2QzTUxISzl6NTJzK1NFdTFaVzdCRGc1bTdoTjFhSXRQK3pZaFNFSnRNTwp1cXdzTnFWSGhOU3lHNGxTKzRSR2M5QkFnaEc3QzAwN2ZPcGVBS1FZaHJFbkRHR2lkbTJvemhJMW9KVHFKblB0CkJFa1lRZUdlUjh2YVRhMEFHUkRsN3p0amdMWmpaUmM0WXVvb3Z0MEM1N2RFaWNoWVZVL3ZiUHo1WUIwa0c4SnYKb0VKQzFleU9PTHhKTmJMbXFVWThWNS84SVJpWGQ5azRMUFpMOEV0azNIYUhWMHRpWUpqUWd1MXlzT2JjaFZwTAord1JOS3JuUTh0Qml3QTJkdWhQblVjdS9FWGthUGdBK0o4cExULzFlMnVXVHhPNHNxT0ZzbG1DR1FWN1dMNXFZCkNScUExT0NoK2hQ
 SjZHYzdYQ2U1TTYweG8wVHFBaHhuYkFqNWFxdW5pRTNML1dBbGNHUXV5d EFMMXdBUkFRQUIKdEM5SFlXSnl3NjFsYkNCQmNuUm93N3B5SUZERHFYUjFjbk56YjI0Z1BHZGhZbkpwWld4QWMzbHpkR1Z0TG1segpQb2tDVGdRVEFRZ0FPQlloQkxZbU1WWjUvWVU2cWd5d1ZVbXhQKzNjbUUzbUJRSlprSFhQQWhzQkJRc0pDQWNDCkJoVUlDUW9MQWdRV0FnTUJBaDRCQWhlQUFBb0pFRW14UCszY21FM21ISEFQL0EzOHpWQ2ZTalBkMGJXRlpNVzAKM2JLRGN5aDZCUWNRWk1zS0dEUm9MWDJSZjlobUVwZmFFSkZUZDNlR20zcUg1L0VrWERKY2FCRjhGSi9QME9PcAp1KzVHS0xtSnl5L0FBdFJYWnpSMkxSRTM4TEFXOUhzbUt5NXNUakdyK2FhRTdKT1JBOUd6dGFUUWhubG4vN3p0CkE4ZXRVTEpib2g5TCtHbW1iZW5wZWdSRXRPVy9oaFhEejJHVlZJZkRpRDRwT1ZsQXp1b1VmZC9KbHFneHZLdncKcHFkRVErdCsrMkxkWEJUOTQ3bTQ5OW9qcENZQitPbTZWMzBOd2tiVlF1RnFNejFnMlhPZStvVnVUaW44dzFWMgpxQUNlVENPcFhWZkZud1Y0L0ZqcjI2UDhHbzg4Z2ZhYVkyR29pN1A0bC9DOTJXc3F6WDc5VytSU2l3QkdXTi9hCmxNV09Ibm83SGc2anZWcXJSNjFta0d0SzU4S3RPdXpnRTAzTlBqbUMrL3I4RkhzZlFlQjcrNWFaejlyVk9Mc00KNm1vYnVpUWJqWmtJTVU5cHdkLzVWcFRtT0FBdDBPNThFb0xzd1crcm1naFhNdy81bENQZkNxL2IzR3k4RDBlSwpZWUdQME14cGdWZFVSUk1CbFFBUGkvc2xrQnNjL3lmWXZTTUhnSGFyNEk0
 SWk2Ky8wNHg4b0Y3ZGJwbGxsb1JyCmRORE1RdDgzRlBta0NMU3l2b2Z2NC tHQWtxS2dyM3JRVy9wWTdxejRyVTFwamZSTEFGaFVrdk8zd2pocEhjU2cKaDhPdnF3a1drR1UweHZ6cHhuRHdCN2RlNmRGNDA5ODdXVG1YVmhJd2Z0VjZ0SUNwbHJhVnhWLzBiaUlCU0MvTgp3NEg3OThhaGgyNUJmZks3RThhUnJiTk0KPTQ5cU0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-31 at 19:00 +0300, Jarkko Sakkinen wrote:
> Null key is not provisioned, what is the motivation here?

The terms here, to create a key and to provision a key, are almost
interchangeable. The latter merely implies the additional step of
saving the key to NVRAM and making it available through a persistent
handle.

The template, aside from defining what kind of key we want to create,
is fed into the TPM's KDF used to generate the key. Different template,
different key.

Userspace will want to recreate the same key the kernel has, thus must
use the same template. Which template shall be used then?

+	/*
+	 * create the template.  Note: in order for userspace to
+	 * verify the security of the system, it will have to create
+	 * and certify this NULL primary, meaning all the template
+	 * parameters will have to be identical, so conform exactly to
+	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
+	 * key
+	 */

The TPM specifications have a standardized set of templates for the
Endorsement Keys, and a recommendation on a template to
create/provision the shared SRK.

Why not use that one then, above something else? We are required to use
a template for key generation after all, might as well pick the one
most fitting from the standards.

That's at least my understanding of the author's motivation.

> So for the time being the patch set is NAK just because we lack
> clear definition of done here. I revisit it only when I know how
> to test it.

I want to note that I'm not affiliated with the patches' author. I'm
merely an outside observer who has taken interest in the proposed
changes. Wanted to share my thoughts.

