Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A55BA3A0
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 02:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiIPA4l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 20:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIPA4k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 20:56:40 -0400
Received: from sonic306-28.consmr.mail.ne1.yahoo.com (sonic306-28.consmr.mail.ne1.yahoo.com [66.163.189.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F57399F4
        for <linux-integrity@vger.kernel.org>; Thu, 15 Sep 2022 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663289798; bh=xKRiN+tRII6o9SvC/3zJQA9qwLpa7PTjKW/Ff3H5skQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NFozRvUvVllyDxNm8mGpQuWHNfVe+0Vmd/ZxLGtyvDHNAFhVPihyJf93g1EQQONlgqSEraxWM2sTEVOfKS7eq+cOV7dMKI7WTJSC//J0RUU+HvsQYI02jErc/+PBQ4CbbQgo046/+oqjqlD03pCNJPxB1RUW8A7roxsDiv2FMG+gtYLlrRJnVn3Jcb7waBr5tfKfwMZqdLg5DHAM9bHfYZWCwZHHxk9n+OLchbJdzhMlQ0G3/B5paKde1VaWcMGmJZ8GiSGUgYdwMmTqZtMCyv2vjweL4O9vH1YHIvjH+9D2TY4O9KTX4ETM/qlRVt6EOMAW+lsCocOESbJO/psVDg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663289798; bh=WmbW9yzUc/no9nIGRczo+NjTt/C2LrnnvT/LDS/tlmf=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jubetYHTnYnbe+plg91aXvQq7Gzu4RAHvHoK+1Yxi3sLZ60qd+fW5ZbR6y4+nbM2qJD/CQMebGxYdJs7eyhti4ADt8aAu+f0z7sG4UH0dXiOp2dsI1Jpvr3ht7XfCB1900W/2b+0LwBAmcl2MhjueK10ywLOtTVMh2KoA+f5ztjFgp5VCnYh0FXYERL93xszZJsBNwoJpYMsc/emFZhyFcA6uFNgO5yULhLVprj64RAGWfgRaEpmIxGyDFwsocqeM1dv+nWHr7RfXcxQCZQaB6P2pwqBXiGIJJZMilKNapACLr0bX/vSF2xicHHVOJqng8H0w930Ct2yw6T8xwvF4w==
X-YMail-OSG: fcI8zmcVM1nySX6lXTbLEFjZgYiOVpZpFxRJjJrjqht1j8DWMgd8dKkoU7fLH95
 BNDqUW3VENgZamOE4TKh4Ve0neoNuxMGhdJYJ26xm71ueJ5yztC9YAf_KmVk.P.WYHL.OnSmz6VV
 F8RpEnJu8NvZ_cXXNA4HBl8.sHuYEfUHq81bVBqYlH23Nk9.lU6IbFBT0EFfAjwEhbq_yKG1GEX2
 HsIFcDolc0njG9Yscj5Q6LBnOwJyjAIdpHM2.fJfq_PFNy5MfvAIDG36gDDLy_XJUjprczwHa6Kh
 gGVOHWTVMjW9HVVOhbJ3jOnXd7x0eDYTRPulHswYIDvWzurhhZBvpoO49E4aDPYSh3oPHrx1qSC_
 ISkkYvz37HTdskMw8BBMBQfYKEt8myY8yP1u3gnl_52ot42IgXh6hRSucG7QGTD1_B5YmwxfXEss
 VJyYnkGwtVdBlfXCKzuMUCn57TLd59BPhCh2TB3FroMYu70GaoyCjOV1MIMtxCwq1UoHawe7Ejm4
 lpPyhmJ.1YlSGZ5PKsP51MtnxeL1A1sjnIgSJlIEvIdHN27gNVhXbiLoPNQxYWlGXO8iObAhnPSD
 QN2N_KnNNDOM6Pgk1vQiqKStegE2eisFkirZXywn.mc56hAk7wjX.6n.mebAXieUtDjmlpS.ZdYH
 uPIa5z2CCVrzhh.7tHvt5ox7M2qxZg8onOsnPe8exln4yPv5NTVe.lYav592bq5To2BUQxmy8XMU
 ZCKsECZzzn47dMi4Wl.Nq2gFofhmBjWzFsklHgBN5pgpOevVMy23aUUYX9Ilb9StI4dDRJI2jfXD
 PE5XQCGkRaywik686Fj72._YPsOTQtOsv8l2arh1X5jOWPYRuH99VwPdtXodQMq_kk80fHn1i8.Z
 fcF.eXuoOdeD49wNT.OhI5i6wZ52q9DaoAtaK2qgluleNBcHsz.BPTnPhZjuHXtyWrU7YoOS2kK7
 1ClQ4iQNNP2gEOdovsOym4vH96aLsXXHfpWfgZWSc.KjMb00vT.xvnDCeB6ncaQbk2eJHgQwJqVY
 lDjiVHgd_iA1B4OhOTJu8YZFAkkicMKSkLvJUfSPCj.KFjsS4YIs2gODpXSMJrxduqnek86nnw3h
 v0WKcWPl5dGHeazK6NofxQkjMSu9gXpWiY8FRt7bmoTlqY6zHCSyGGzs7cdR2GRvkqMQggGiBwcG
 rEhUpAzbDo287MXBwG9vVLfFeVRAM6XKjkwDUbL0f9NLyks8B71BiF366OKyhguhVfeWFzPCfV1D
 1I6ISkDtf7tSc4IpRVQHC1pmQNuS9dFJMk9v0moddp35AecVKgcjHiT6rCrUGw8NqBv55SYsXhOR
 vs_4xxIQNCN9vmR_w9Hgkhq6yDlpV9O_6rFmZg7GBQ0jTrPKFCI2HyA5yJeaaleuAkAJec4_XPTu
 fBu1D.rMNewQQ8kn7CBZyc.wnaCNBjE7OjbY2u255uqsJqwg0u.vOVxWWfjO0UH6yM6r4PKjDAA7
 AfNTR8ZeBofsYuoY5nf8aS3YkbEKRT52I08adwzYNvgYnwqBUvfvzsUaEyL9WeCgD9EJgWSCAuCc
 g5vGgkePv3yCCAAV0bUuEyG4Ec6zH5sV9f_TY9hJoJlNH0OdZ5C9Trvvkf4RFM9EknJtr_ZhuGww
 lm2clJFDMioDM8CIWbfv.EFoZs5C3tIKhvB749LWIWqCl1r3IGZqAbMAL1QXyRHPou8iRT2bJIUn
 17EqDQJHEAaKFXmeGO5vRUjvprLREavnzfw8VET0Nxqc6U_TDgaZ_5ZrVUxTk4_k7eu1ALh7UwSH
 P47WTLn6dSqaT8mJv67xewLMkstsvD1tLfTSaKKuJJG7veeXgpVwFIgfK_DX.o_eYA5jtU35OdR6
 qMpXGVEL.dHlmb5pCidBuL2yAtA2dpZl1Z27TmUfPbqeSkaJoYghyLrhPY8lmlkJOI3WxjKTQJZL
 PTr4Kpkb22gI3ZMG5kDIylbrjkcsXmgSrBPiDiRhzjEbMeeUPjAna.mLReO9GUTvo.NJbxh5rMMD
 8wGT9wXdJRxKKGy5o89LqHttmDnPNk0M_4zHzmSbYRxKRGxVNlDjjFceSm8TtqOoKzRxieVKW8X7
 jHvmU3CbXO0CR5uQ9tuPqJNLIoNJQLkyYa8COe7EPK79jxcOScsEoaVYhgGv1cio1HN8RBOGp2aY
 6AuZrT3Jc8piHv1UhMokg8ly8MdzVeOuOSKwG2SfhtK.6.4GoxFwoVyrBwl_dxup2XzW4mh6VejP
 ZI8ndST0gVUDtRrXIOSdl4XaE4_KLz6dhFRyHBw8bKnJ3TrBk_68kE0dD82jZ9SBA7F1kJPyACpU
 -
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Sep 2022 00:56:38 +0000
Received: by hermes--production-ne1-544744cc75-mbjj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 906197aefc0e524116a4d5e4b45ad582;
          Fri, 16 Sep 2022 00:56:33 +0000 (UTC)
Message-ID: <7234a3e5-8b3c-3ac4-2e06-c6cffa46c10e@schaufler-ca.com>
Date:   Thu, 15 Sep 2022 17:56:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v14 00/26] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, casey@schaufler-ca.com
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/15/2022 12:31 PM, Stefan Berger wrote:
> The goal of this series of patches is to start with the namespacing of
> IMA and support auditing within an IMA namespace (IMA-ns) as the first
> step.
>
> In this series the IMA namespace is piggybacking on the user namespace
> and therefore an IMA namespace is created when a user namespace is
> created, although this is done late when SecurityFS is mounted inside
> a user namespace. The advantage of piggybacking on the user namespace
> is that the user namespace can provide the keys infrastructure that IMA
> appraisal support will need later on.
>
> We chose the goal of supporting auditing within an IMA namespace since it
> requires the least changes to IMA. Following this series, auditing within
> an IMA namespace can be activated by a root running the following lines
> that rely on a statically linked busybox to be installed on the host for
> execution within the minimal container environment:
>
> As root (since audit rules may now only be set by root):

How about calling out the required capabilities? You don't need
to be root, you need a specific set of capabilities. It would be
very useful for the purposes of understanding the security value
of the patch set to know this.

