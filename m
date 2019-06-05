Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DD136211
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jun 2019 19:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfFERFs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jun 2019 13:05:48 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:42303
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728729AbfFERFs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jun 2019 13:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559754346; bh=wQbZNCwjdzU8b/D11B3T1ODeHuyFlPjfjQxF0pA2Rvc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=E5a9Ptb1wlinwOfXFLZ5KOhUFhhegkxB7Eijsu6gPlJ4BisSF0ACCAieWia58KuLyjFZPDqFem5Z4io0nEQaMrhfqdERtHQ9veEGvXhlPOoJecIDEMV3Vm8rZZxvACLPZZXVuGbWLhtZdBSVnh0kobzhb5gOxKAFZYvV0jLv68cGVSsroGR7UMZ0aSMiBuZt03vlj32otWAOTFxP0D/U8rogtzE2eMCtQWvupizzsSmVbqx/RI2pJyZ/q0DNIALSReQ1tVnXpOlFSowFugKATFRDoKZMw5lLx8/uXQAGzKEyjhZIzKc3iRS4A3yBfuXu7FboaNaBzcdmLN2G3Rls8Q==
X-YMail-OSG: KO1BEOUVM1kKmhkHqZSWYfXiyPTllGb2YBUFqX.PTI6qj0dBq.BLL02odYJEfhF
 ILpdESpavP1aOciSoI2OcxAhru0oE4I1pZFajqGDHP9P4roD6JmY645he4J8p.G4Q5QJyQyq2ard
 P8Kch8vCLKA5cXr2b3FVCMDBehFTWjCrliUadX.G2Q1oV2u2Sf0bU3zPSeyYX2JODt8eyTl1Bwch
 NWgHFBDZ16ibOsi2Mlebv_FDHJRh7k9EBN6OGP1aYo4y6xV2vsK3i0C071JFtjnFsjlgomEPRwfD
 RVhXUpAv9S2Qwr_yangfdIsLG3T_hGsooj0UupkhwFOP2ZB673SjVEAdnJh369HC1cyeRdGE4R6_
 mYgBZ9M_QQyVkUR5qqEJvOwfWiheH2PXXShimKsX66sEySKBuRrRZ4U4uwXdUxOyeC_Gseh1Cg3o
 kA5X0HX_SHKfNXMr_WjCbM0Q22Xjkyp5QRwWfewL9ZEODiNVfxnfkABrpOjQtMP_5fi72N_I6KLI
 HpbImsyXDUvQghGdGuvHmRkSp6IyhueH79VeGcOtBgpt2hzAGrSCO0nzI9ld7IZeO8we5gkRvP5F
 rmjgnCNGaFSkHx2phYdisN6eH9tvITIUv2c6WyBgu7Y3xikY6Hpa0Al98didNxQ4XHWaixPZkkPq
 sJjxlfTXBt8JR5vCXbYukQ6DxAfMwAyLSEQDgr4mzySjNcg2u7qQi6F6IyX3JXRhKe7sp54rDhQf
 LPrq3CeV_fPBiloRrHQBvDZg0e4XQy6xAmujGTU_ix1PWodTK3glI.6GPiW5vRNmpj26TsiVrKEE
 S5cR._KgI3AiMHRlrwH8rFCdtqEEbyBn94PcahiIDN5eSeDIaKm4nll26K_gPX3XPln3xfaVUEsu
 dgV13J6BdISPSU7_mSWqPOk.agQNPrUwwZ4YW2Z0EI3iRpaqhocJXmUtM28hIvREoei.QKy8moj2
 HRoWFUunF349EPx5QF0Br.GDTXL8Xehj622hXFs7M9Ztm_BhXGP6.O0cTb2ZhCdQHWWxKDNfFGuJ
 .wU4XeAawRofCSmOCAIsVpjvJ52n6xj_nEP6_7slnHosetY0WTsjmVECCH03zVnac.HICprktZe7
 KXbjBctpmQVC.cHJy9FrNpqaXBFN7UliOWBY8GJeVm0_artAvWhQ5a6Fb7Ew.UjA4fS7Km2NUQje
 DOYOtgkk5DY60pYIGZjZRyxjsCqkifBTR0PlrB9y5_Sw12.zgrvLql4RKVSeTdXwdlSeaGDDUWBS
 cCdkOjJD2uB3yySWdxd6uoiT2abmyCYiaOVQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Jun 2019 17:05:46 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c342942c7e3cfb3d16c3bca60c08b2a8;
          Wed, 05 Jun 2019 17:05:46 +0000 (UTC)
Subject: Re: [PATCH 1/2] LSM: switch to blocking policy update notifiers
To:     Janne Karhunen <janne.karhunen@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, casey@schaufler-ca.com
References: <20190605083606.4209-1-janne.karhunen@gmail.com>
 <9121835b-d6ac-c9d5-349a-1ef7024c6192@schaufler-ca.com>
 <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1edfbd72-f492-db17-8717-a8cfe30d9654@schaufler-ca.com>
Date:   Wed, 5 Jun 2019 10:05:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAE=NcrahPmzmB-xJwxzXqaPGtJY+ijbxV4wXz7K=y-ocw4Cmwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/5/2019 9:51 AM, Janne Karhunen wrote:
> On Wed, Jun 5, 2019 at 6:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
>>> -int call_lsm_notifier(enum lsm_event event, void *data);
>>> -int register_lsm_notifier(struct notifier_block *nb);
>>> -int unregister_lsm_notifier(struct notifier_block *nb);
>>> +int call_blocking_lsm_notifier(enum lsm_event event, void *data);
>>> +int register_blocking_lsm_notifier(struct notifier_block *nb);
>>> +int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>> Why is it important to change the names of these hooks?
>> It's not like you had call_atomic_lsm_notifier() before.
>> It seems like a lot of unnecessary code churn.
> Paul was thinking there will eventually be two sets of notifiers
> (atomic and blocking) and this creates the clear separation.

One hook with an added "bool blocking" argument, if
that's the only difference?

>  That's
> probably true, but it does indeed create a pretty big change that it
> is not really needed yet. I'm fine either way.
>
>
> --
> Janne
