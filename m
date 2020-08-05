Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFF23C2DE
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 03:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgHEBEh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 21:04:37 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:39423
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726721AbgHEBEh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 21:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596589475; bh=15yyDM3bVAWECgKz7oLx+I/ZvqZiZU4J8rThZ2JKCCs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=r4WFgesdP5gl/Rbe38EMe5736cYNZXnOEf02AIMJOAl6q56puEMVvpxd+h20+KNNeoBRoCoMYqqrPH1TnC4d0rP8120dKGC4QTIsS0xZQZzNhT4MDHIggo9jgrYBAs3P5ghMFOABP4pCvi4xXNkSIlBENgzYfmY108RW+w0zdGfOF6x7X8g/P7vrm5lrnlROhJkxy0Ap/WJb6ERsMCAEckgECWe7qEcN9tiDxhXTvBv6ujS92jDj+VA1VVN28xO/tMrW4aQw6GR08HYzS8L0cwpu5FRj1HykZ05PUf2pcEFrWL8OHZu5cTrLjUIlI9ppsuTCxykYwadV4fPPEU47Hw==
X-YMail-OSG: zA7gwXAVM1k8jezbi.SsnhgWqQcQ0L8EljVIEVzgzTKlnyxWgJXTMD88rtoAkyN
 hxX8K2pKGVFRl6x06onco_or1m.dIJExyO6Rs0eS3R7E8bam9GSJGebEoOovc1JmYk_oMmSRYboi
 0Oo.kpgsTEcyGWaOAvVeIoLNQwhMzlwHS6oCjQ7sGb80Z1yjgQww_AL0kOZBDfzQidpj_vbtlWLh
 pz4zeGPL8T0PK.CTMca4K9okeZoltMiZYkTvRAot3oCo5LZVikYJ7ImMfg9hvjJZ689Bj_6AulBc
 KEI2GbQQXkcAXIdhaoGJBVEbUEYfe.E5NMTzbpsOoRMZp8CqKMAj44kTDzpvu4ydniD0XcXvpK07
 lhV3328lNCpwwbzW1fcktjIJeUKs8QIvfn3B3vjS1pWa18lDdSyXBwfP_UOTjCxYdTeaPJ00s6Dq
 qO17JRo5elAYuWpvxwCnWzOKrRNk7of_hHpbekTTx71EG9vz3fdHgPWWfMAOojtbEdAK2wiHDLRw
 p0_dAbqR5_VfTQpvKrJ5kut5nHQ.J_5FZ9ZeAjRvUs2hAoGS36NU87miFlnHbrq3ryjwoK3TUixu
 or806SAR95qOP3HsH38iTJeKEhoEx7rsLmi2Ek8_BB1Ul4Tz4KyKXq7QKOMLjChH8j3VjgfGgWoe
 JJlTuXO0N3jziK73PZGqb7duirK64CQBfGtPoikLMRyF47ki7iFenv7gkUdutabp0guUq7kppcFj
 zahHSeqUaIO3YEWaDbhJYnG8.QlVtqg1NBYxWMZJTvfUZEB93M8GoHmZxep1e0e6ghfBMv26k3Gn
 jAr8gtL3aoyVYrzoc01W1oazWGOH_OHn4cntu3_NQjrdFacHcPaWVSCigFtvFVGPDnIOHCsPaNyS
 tKaORpP4c3a9JzEwOXmKq31ugsW5Rk4Wr_AWcl5lJXxZ5GCAtjsfaC6ATJoev.Y8PwyqUZ7wm8l1
 0L.pCU1aL36c51pbuskKO3F6ejHn_Gln9.PI_M2m9wYK_iV8XF3srPIeTgAzXiEjpExmBU9zJzXw
 8BxYSgsqIT9DTYaJHGUOEp.AQHIkyP3oc29KnwUTQLkYrElTtgD2YPPwq9LcL2aB0Uu9gj4a8kly
 Cdzs3eXmXI4x0lcPm_j1r0H7Mr40BD8uy7TzCZoLdXpqlQoLnIbGY4RWgKncOa9urFrD8xfoa6T8
 COcX32qRUDMtXdcTHAqcunJ825yiwe77Zd9NhekhZFoNfTyvd8Gl1RTghPaSeZVZ7JDmsbe6R5Rd
 OIruT99L5t3xpIXim1cfm9p7snp9p79vmh.0cDDEVhgD9323lSa_ZMwTsdG1mbcnSf7KUgjwaIoI
 Bx9K8ag1ybsFnaPtGA217CyJByrwirXFmU5_k8eyDNGb2D_LV4_h25wYw8SsejBKD
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2020 01:04:35 +0000
Received: by smtp428.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7f4333369d465d186f6d9a97b53e0a06;
          Wed, 05 Aug 2020 01:04:31 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, stephen.smalley.work@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
Date:   Tue, 4 Aug 2020 18:04:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805004331.20652-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
> Critical data structures of security modules are currently not measured.
> Therefore an attestation service, for instance, would not be able to
> attest whether the security modules are always operating with the policies
> and configuration that the system administrator had setup. The policies
> and configuration for the security modules could be tampered with by
> malware by exploiting kernel vulnerabilities or modified through some
> inadvertent actions on the system. Measuring such critical data would
> enable an attestation service to better assess the state of the system.

I still wonder why you're calling this an LSM change/feature when
all the change is in IMA and SELinux. You're not putting anything
into the LSM infrastructure, not are you using the LSM infrastructure
to achieve your ends. Sure, you *could* support other security modules
using this scheme, but you have a configuration dependency on
SELinux, so that's at best going to be messy. If you want this to
be an LSM "feature" you need to use the LSM hooking mechanism.

I'm not objecting to the feature. It adds value. But as you've
implemented it it is either an IMA extension to SELinux, or an
SELiux extension to IMA. Could AppArmor add hooks for this without
changing the IMA code? It doesn't look like it to me.
 

