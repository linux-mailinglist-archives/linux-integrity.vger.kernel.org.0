Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AD4C33CB
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 18:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiBXRdF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Feb 2022 12:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiBXRdD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Feb 2022 12:33:03 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C81D5285
        for <linux-integrity@vger.kernel.org>; Thu, 24 Feb 2022 09:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645723952; bh=eLIg2lJ19nzizmVDA0nkElf6Xtn+HvNuyJ4wCD96xks=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GV1cxOESMWrng+3IL98zCg0b8FfMP9E0QF0olWMSlnR4JXpobjqWuqqJi5NN2VdnjbE/nPSoJ2Y+wbIVYsigDzqG4zodY6MB09vKylHhAihzgV/iVQjjLwW94JrovdJFMEShy76yqEegNwcPZBRT9rwXxMikBr9dESdNPTfC72frYgCIG5Y9ZYF9eEKbjyJE/T5GtTxmqJAChm4PiG2OYSf3i3L5UxdtcuNfErXZcRCpwfuVmUmWF2G3shfX1RBWBmIwqIWo/V9KetUgLs4p92GmP1wYAkBUZA52oZNQXziL7jBwCOy7QMXsahVZTVehFbUhdH6oqOdEMNrg6VPULQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1645723952; bh=mhjr7k2u7onfh4com4tCPakkAZU4P4wXa0QL/H8kIxd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lZeq4jpKtHYKZB6/IHA4Lp7IF3i/cYEb6imbszdXIjlLKGtVr7V7d144XDpoo9LQgcL+VP4eKJ65JNS72PSAB+qRb/acmEgC1pLcppWH8anGwt5bkVemR4EUEqwxrJuuAOo5oz4O83DbAO7HLaCNhZxkzYr3q0t4CGeYCfMc/joKmQULndJSm54IMMJ1a5ZNZTpT8NU36xxU0uvnnEtfCo/c90PnKHJchJhRZ2Up83qkoLiO+jJKgDO22t1kbMr01tnPrIeTAe/69l7I9iDgZHc+Jiffw8qDB2FQkNfW8e74MFEdimV1C5gcJkylbKMFFmbBm2N1fJLfgkXOHLl5RQ==
X-YMail-OSG: EXeYNvgVM1lbU8UFCrcoVIe8j.8RM2C.KyKcQoPW9RQX_8k6fd9JEFx3eeRqM6O
 0eREqXJp0RUPK8oqq3g5O6Ts_MUnPE3p1AMdLimafvxcLq9Wa1EHUZEJFNuR2uUo58RvBT1fQiRO
 GdSoPgXx5phPS.C.ld5SzZXv.caXoJCF8PmROZeUMaAKCihWOeIoseq2h6cgvl3Jxuhdgipfar6N
 RZ6SrR_b21JRuHJnLCndtpq2UTyNCtBDQuBjmtR6OdXuC.StGjAytHSaIJeg_Dn2svDmu3MEuLKT
 G5FoxAjRK498iEjHYguVyjsrHh494vjafPFrsp8RrB8gJG2Nal5OqIWnAjZMtbgGjLgWvD9vnB74
 NWGyE282yHwNJBj96Jr3fnWXw6FXH.z_OPf6ru5gR9SZcH74hbpqpWiKRIgqigvRurS7q1v50fo2
 a2xvwPQ7wETgsfksKKQe2qU5JBxS1WzXpnG5Zh4pI5FHy4YR_u0M0L8hoZcYGijFB8YsfXe2.8c0
 KsINFE20yeS8uINwrKhJMpx_IQ1P01AP0p8jkuvgdBv7740HUVVs6n.T4zMKG.TCnSpMC6a6fUhS
 ERweyFsKez6CGZk3krR5gET4PV3.5u8wshcFs7uZEoIxG3YrL56PHcSWg7KloMaOHpMtOm0T7qg5
 EKIGMlIpnWyo3fZmW.9avxPACGpsbHHkDbiL7zOyUC7DbbsmsSOZrEYaS1tOZgrLuHSNDcA4z072
 YVBXyc_gdQIbWb5q_ufs9BXtiu1v2wq4fCKR9osM54jUvDbLxUJZWuVK58MTWYDRKZvOtIdZ.Z9u
 V074NDWkAB2rYkidYz0NEooYFCTqhjsJtcjYjTxFOgAF37J4jo9Gby_elrJcK0zUIY6GMeVkPCjl
 SmAxLfCs1RUh0DHmsBD4v0dYlQfKONo4OsnnF2Fwjxr7YJTMMdmU1i2p9Vqu8LiMruDVU8VxPEam
 OdWMmeqB_5FGBhWlMv2G50jaGRAY47gGFc9g2G_JppGMIcLb8FlledDljNAdU3NQsP0caEjZ7f1C
 00t7p5HEurXQTTKBeDsacEDpc6uJ5TflqsTZu0Y.NHYhsGPozN_G2vWjDH8.B6s52yhao62Hryoo
 4.AG.q5Cn_uldXdU53TUMaTF5LpSQb4UYVOJOfAHsrMKaPNljoSzqTNkM9EVO5ER4ryEgmPMBKkg
 ADUdvnMgVCTZSDrBGbpzGZLy0jFtSBZoR_ctl2LNCQl6UQMKD5_v1wF2URVsBWrJ2T5LIP.AGWuE
 oBacFtFldxdmw.oZ0RL1eG3rp0kLI.lwhInTOQCQvVx.FF0FNe5L02AGISvtZQbxYdgILMnuUNXM
 2Gj2Ej9y.S3bSY9z3df6AJ7wIALWm1bBxtwMbzxrx4xcomIB0iO3qOaxYB8huCMSkQkLgXGa0Fe2
 xouS79zpR.yMjkHvW.Z8.P1YGjil09k9KA4bJZEd2W1f6FigMzlVk3A9v.E7olXSPLOZi70aQjvJ
 CinpXjoGDp0obut59CCDAIZEdKqGS17o_CckzoWsoCZzd1yNoLrBL922AZLZzAIV4sJ6iAUMHgh0
 uV5IZGCJRphvyo.AqDCF6rj4UeNvclHsD4M8V0Isog2Z1eIA776ZV8N8KYl2ddNYbIynkhCUpLEc
 wpERFVSyNMW3_XQnceIej.2mPAlRbhHwdZ1vkAlMWzTJ_NKIbGnMpP94GoR1cgYVe5XCGcHZ724I
 912HyORYDbBnGqZlICSEhOIaUMVG.6_g_8fnYmBqHnHK1IJLDByD4sQb28zSh7OOmNPWns0nApH.
 7AoFiujfO9Lcn0.u_STrSS_x0oAExCx5TqwsH6JI0ylxeYbe8wCGsH9x1Kr5ankyyOCWhIJc94dy
 w7X.xoBCU3pZB9aB8kBaLExSOwiJ5G4wLPXX850JDGHFEH7EBnOrRvmoBxGmiXeojkN4j5guaL3M
 zQP2qYI1Jfw9wZdBA8728ctQx_QsaE071Q0pLF9N_TOn6.qr5R_5nj5nVDJAlxJAXpRM2UE0Y4X2
 2IRqQOO5SOSOIae.DyjPPkvPx1DiC4saibnu2ps7XYmjH32P0g1zHPTeT.HG9JgnbILK7JTvbnSI
 fMgE6ie5ZLm2w82NxShhqalGKkWWHbQX7uTiUK8YvOWC4CpQGrOgL5EpjWi2vWt7QSjkUiOKoLWx
 TiPLN3DPSvDidaT9mpj8TIvGgudcfwESTQzkU5FSLH2aU28GA0u3tNSXnxThkrJQ9znhg7_Ptl3H
 M2HQsyVXpABvHb4i514QRpa9c3VkwFPViYFM_PsByqDnNXow2MWih14YXA75kQmwYIw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Feb 2022 17:32:32 +0000
Received: by kubenode500.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3b5e45a9f836ff2b85e501e5f122e7d5;
          Thu, 24 Feb 2022 17:32:31 +0000 (UTC)
Message-ID: <418628ea-f524-05a1-8bfc-a688fa2d625d@schaufler-ca.com>
Date:   Thu, 24 Feb 2022 09:32:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, zohar@linux.ibm.com
Cc:     dvyukov@google.com, ebiggers@kernel.org, jmorris@namei.org,
        keescook@chromium.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
 <20220224142025.2587-1-pvorel@suse.cz>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220224142025.2587-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/24/2022 6:20 AM, Petr Vorel wrote:
> Hi Mimi, Tetsuo, Kees, all,
>
> FYI this commit merged as 92063f3ca73a ("integrity: double check iint_cache was initialized")
> is the reason for openSUSE distro installer going back from lsm= to deprecated
> security= when filling default grub parameters because security=apparmor or
> security=selinux does not break boot when used with ima_policy=tcb, unlike
> using lsm.

OK, color me confused. Integrity isn't an LSM. It doesn't
call security_add_hooks().

> @Kees, @Mimi sure, people who use ima_policy=tcb will just remove lsm parameter
> or add "integrity" to it but I wonder whether there could be "integrity"
> automatic inclusion when using ima_policy=tcb. Although the point of lsm= (and
> CONFIG_LSM) is to have *ordered* list of enabled LSMs and it wouldn't be clear
> on which place.

Why would adding integrity to the lsm= make sense? It's not an LSM.

Sorry, but something is wrong here.

>
> Kind regards,
> Petr
