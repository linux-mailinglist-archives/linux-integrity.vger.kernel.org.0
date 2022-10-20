Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5832F60671F
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJTRgv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 13:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiJTRgu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 13:36:50 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B68164BF2
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666287408; bh=90K+murjuENhFlusgWkcx5wUJTQpmjq4sbDkQy6D0II=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ow5+D7rGh0vTHr2ncPjKyRFEqKppFeWqmF3li3Ab2H5aqyui+8uAmrjg1jBGOYMHAOg5GgOMKoiYDgUctg2yPSvKCvhQrHzM4tAFTz+Dc82zE3d+jcnoQhAuwY84oqQwGLGIA8wPgXfuiydse+ZJZLtjdLVk9kSyYFPx9aXyhwLP9WsQ1cZmy45ELJWd/argI6FTu+0vDROtTN/R6o+DPrfwYrRtlm5FhLA9u//5GxdjwMlr5fzQ7MZK2iFNzA/D6DM2HgZQdAr6taIGxtZjrORJbPVAhzZ2igbshGmmXdMZRRuc5oiGUFzCXbt0F/agu7iZ33jMzuQLYV8KE3Xu3g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666287408; bh=sXZ1gseCffArYNyfyAhiNiKCkvCDMuZh1BgvMix385E=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Ktd+Ib8hAeVfRAuRevkExqgiva6NVa3gEGpXZKESOt1NL/4oak8AkDNT0JSdT+6yFXkldfwh/u/67oemLfaLv4bN7KRHd1sT/VI6WzhJaxaE/1N4rIkhXnO3NGfhLJsAbc0LqFuWkbF+XDd/ydytWuT4/BsfhL9f7uknhFrYuoOMlLqz/Mrk6mZbc+44zUhuUR1u71uTHYWCyEwNiVOcHoJA7kn3gqu2+7vFPoiSqB5wy45Ax/aRRAyLidynDTUBE420tSixdGzMOHPmjCXJAX9n+IUqG5AsqfoUAB9QohY0A+YJEEtvOtvo+TPSYc+2VodBE2qKfPG9HDx7AECw4Q==
X-YMail-OSG: w2wWcawVM1lpVF7NWPK8g2eFbRib56VqX7szMq0HVVJys1hMk5t.T6eQ93Bl_Gv
 v2R5LE2Gyl8gVtmW2LDrk9uhIGSCU9owG8iEPSTKLtQbsB5JzQQ9oGmJxbkjWFK7FjEoiraNQmSG
 o.w9PHkctV1dIYBunwm4YhhxH1.0aze8LQsbh7YunecQxBmSFK62cQq1eRhKA44en.fVnEVG0JRa
 lWxhquh9u6EmvW0HynTZdvrd90hX.7.sOUvvGdp_Bi732FGmcf5NWswCm4hN6DBwlhB86PLvasBW
 BIFvAKRDOEuHHu.dTV8ev7S1flT_58RUXSVjFNafz3vQ04kcRGaoO4eixoh6mjYB.0xcSBQNr89D
 zzGCVPK53Kap7TL9OFNW8CNEG9_M1inWEG_Ri4Wc4tEYgXYIp8LCcH4HRKOKjlEn1rgxysUb4ZbE
 M.ls..Fm0Mbk_eaGdFuvlBAczNQP.4TYhlBsj22dvn0b9o5tEpJNErv4hQ.2QLnW4JYXZgfn3ZhJ
 BEJfxde2W.UUOxbGmp.La9vdOND1dJgeLn8NcIqWgp36vYp7Zp6NyAxc4lbWzBUAk7.t56Vy.iM_
 DRSQrHpkWtRBkSysZHEXFZv2XHIsOpHMkGfQIRtgTvPvK4yxZk9bRLNMlmqeCQLoHcEcWy.8.FPu
 9Bs_NIcboHB8W9PURISf2cQYpgciljDwRDDaIUttkdemEJKb3F3Hd4CMY9ru0gdZP8n3wdG4Tzrq
 ZECcx.3ZTo1yWxP9NOzXSqdmAmnEJ8SgDIiJqRB.K3xlfsin3cnZKePr51HG3z6oe8tay8Mf4qot
 lpj.7_tHCW.ARE7ft5rmjHbxPekPTKLdoZujrVWTA51BQpvtmNT19_WfkUhSuPVIx66fczxfOcHw
 0Dnn39OGUmKtvKlK9FHiAMO3gLTvyzjYtt5pgT8KA_MtiaUJJTGrKqvGS0P9D.SaNGlhzVVwNPxs
 rpA3iVoeUakPTPC1aIafc_6ErDFag8ZqarHz7mvhjnboEgEmW0mT5Bx5XpWx3IM90cq_Fa4DlWgQ
 4njn5prymMTJR5IZrDb1x8hlI3DaAY1ehgEZu08VnAtM7AZWx7c2TC4eLM2LbaE_dhbXggTeXzb2
 RrzEqXTsA8PoynvhMJC3bjH9cxUGO63yKumR1RBAOlENaLtyE.WN5nT70QF1u4JgNx9hhcyrMDHx
 KAQa9trzbOnuEmIpskvDMByaSQnhtPinB4kYpyO0D4RBgVCdxochIDS1QnjdI7qQ0OKOeooW7Im.
 _3IqEANgtf22ZS5Q5P2ooFm09giuwazvITSaMr20nM0qZ0ArC_bBsCW6zAo7kM0K6oG7Ee8PJMBG
 P_WTC2CN_8cXVnJZQHEIrWiCj737BEWaQTUCicRH4KzKWn9MLPPrgBPhBhsDkzZD0EdzMKVCcq_0
 LVgByiE2AFeXFyPgBzl_p1MQsK9JPh0Vv2NtUJSqu0VVKIMGMOBZZZu2lnHzGS2VLxpzez0RPUgi
 XZt84gFibJFhhmS9DlzI56jh6F2YTmXgvnvpv7r88MMCGD4JKIAaknNLgXQunkTtf3d._1Yqra2Y
 DyZNYc3nptIRwaAk7W.qzdFLFq1aasqTE8JgKaRbX8nhSs3v8mee.Q.2lAdMHX7t.E.jqZNAssNd
 luICX1nGPK39Jjo_TuKBVquXiG.aIXHDIu90fa4otXpqprdu3u3wez5bwmNngkedPQmPqEMCOais
 URx3JK4FHkkBLDT5muVUq1A2lJ_v_3p2jRG7Q.abOzz4NNAF.Min5B7EoAvoLXO8QYFK6blctBSq
 N3t4d8SAnYtB5t4y_YczyFk1tLmNo4kTxlCWZ8qZgy6yxakUCsjTjann0L1hJXXzKjKWHcusVj.w
 f729XhxmzGci7F8y3SgrwxnD3WWZ0GqmXzKnReHERUq1fENcmC3RTIK.kU1umUDLdShCfvsVa.JU
 ZzYwdF6lhCbCMjrnTMeoNdZvGbqNew2.7Ds_lu0aR1R7x3Y8GaIyMJVj0YpfCk.FDGRnZDzAzPzl
 ayH421cOmNqSen_Ifg9UFUHIOzYpck.sx9fX4fswRgyoZ6w.cQ8y4JuDMpv92zajuB_IMrlOXsHr
 2j.DyP0EeVs8Wxe7WmLHwbEMWxVwOC3kQkDLq.hSkvQkh0MsMVMowTKd8cr.xoa6aThEYVO63liR
 1w56XN2dHB4JN0hp9Je2XpffkX77kuVpRUXoXk_54SDHvzYTWvQm1Wh2ops7jgbcbHtjuKL0M5mZ
 6BEMPPRXwv2dCRexoo_GFaZiaGeUz1bIBiFgzHccFKtC2qGKfj4wFV_Lhl9CVqjNGlY2t_AHw2J7
 VFh21ologS1wV0pmBTtTKulB19q8sBQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 17:36:48 +0000
Received: by hermes--production-gq1-754cb59848-jk2dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 427c18a5c9fc4debfb01026bd34ebae1;
          Thu, 20 Oct 2022 17:36:43 +0000 (UTC)
Message-ID: <f996f66b-45c8-7ad7-49aa-4502028e2c94@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 10:36:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 0/9] integrity: Move hooks into LSM
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        casey@schaufler-ca.com
References: <20221013222702.never.990-kees@kernel.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/13/2022 3:36 PM, Kees Cook wrote:
> Hi,
>
> It's been over 4 years since LSM stack was introduced. The integrity
> subsystem is long overdue for moving to this infrastructure. Here's my
> first pass at converting integrity and ima (and some of evm) into LSM
> hooks. This should be enough of an example to finish evm, and introduce
> the missing hooks for both. For example, after this, it looks like ima
> only has a couple places it's still doing things outside of the LSM. At
> least these stood out:
>
> fs/namei.c:     ima_post_create_tmpfile(mnt_userns, inode);
> fs/namei.c:                             ima_post_path_mknod(mnt_userns, dentry);
>
> Mimi, can you please take this series and finish the conversion for
> what's missing in ima and evm?
>
> I would also call attention to "175 insertions(+), 240 deletions(-)" --
> as expected, this is a net reduction in code.
>
> Thanks!
>
> -Kees

I endorse this effort.

>
> Kees Cook (9):
>   integrity: Prepare for having "ima" and "evm" available in "integrity"
>     LSM
>   security: Move trivial IMA hooks into LSM
>   ima: Move xattr hooks into LSM
>   ima: Move ima_file_free() into LSM
>   LSM: Introduce inode_post_setattr hook
>   fs: Introduce file_to_perms() helper
>   ima: Move ima_file_check() into LSM
>   integrity: Move trivial hooks into LSM
>   integrity: Move integrity_inode_get() out of global header
>
>  fs/attr.c                             |  3 +-
>  fs/file_table.c                       |  1 -
>  fs/namei.c                            |  2 -
>  fs/nfsd/vfs.c                         |  6 --
>  include/linux/evm.h                   |  6 --
>  include/linux/fs.h                    | 22 +++++++
>  include/linux/ima.h                   | 87 ---------------------------
>  include/linux/integrity.h             | 30 +--------
>  include/linux/lsm_hook_defs.h         |  3 +
>  security/Kconfig                      | 10 +--
>  security/apparmor/include/file.h      | 18 ++----
>  security/integrity/evm/evm_main.c     | 14 ++++-
>  security/integrity/iint.c             | 28 +++++++--
>  security/integrity/ima/ima.h          | 12 ++++
>  security/integrity/ima/ima_appraise.c | 21 +++++--
>  security/integrity/ima/ima_main.c     | 66 ++++++++++++++------
>  security/integrity/integrity.h        |  8 +++
>  security/security.c                   | 78 ++++++------------------
>  18 files changed, 175 insertions(+), 240 deletions(-)
>
