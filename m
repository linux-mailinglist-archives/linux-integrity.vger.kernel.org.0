Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802FB51C520
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 18:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381975AbiEEQdV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiEEQdU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 12:33:20 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18F128E08
        for <linux-integrity@vger.kernel.org>; Thu,  5 May 2022 09:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651768180; bh=BBoA8CuRgkbA7cmy3x62CIFOIJuQmkI5nM2k21Q2MQY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ihQBmtSn1+pdUrTUfmnYARsRzjV0rUvXD0EZsMkevLZ3gEW2Jgo3bOEZd/y9sYAZDg+vmESB0306l8qb8NRtWyZfK7fSl2HmoGCNmT2sUrTYlPdAwTGZ42UKfX7yzffTk/BKL3ipILCCotqvcpYwk7uKYjikebSnDR+H3Na+0ByXYN44GJDTiIYIp28wrZTLyF2n6fFa/ZvCPN4XmS6V0Abw63qn/VnKuf0icRYzxQ1js7uI7NBU5ZbXqlgPohRyjAZGwIZgMj/ryFqvH2ej3qZHnPKW3A1F37sZ+RxOH1gXslJZ8uvnRpQKEAfTVbILvvUNLp2z1DGY0qTDmLb//w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1651768180; bh=XYk6WA+A2wypDxVG9uSPSh0LN+IeUqUwAyUGgpOqZZp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=sjxwt7vCpDl64g3JGMGRGCLxdemZ8vGptaT+tB7osT+gkNm4roeys86KKBs9fcIC57Owh9EUystpoCGhrSlKnIkW0Fc3DU+JqQS8Pf79BFZLsMT1eUOAdw7oxSE0ezGQRDVEUkkFYRLocjqXYWoXSaE6h4AGkRAAwtfGZyrpMPBS7VTwYA6xG76jxlwKZI5B9NOTBbJHiBJDaE0hLNDJNNojxBovHrbwhNRONBa80Nfcp224lIBQow0voxF5/A7+SWo93w5343bWjEJOUGRUwBsATsF1qRsuLcXTP8kDFN6oVk1PDkD6sXxnAbkYy4woxPZhQRv00RCdAXoxsxumSw==
X-YMail-OSG: pJt4TT8VM1nGmnl9kZnN1WCGvMTcLo0RjHLt2muSJ11KFhlldg4TIbu9dAl43b9
 rDjeAqil6mAQpXiq8b.0kWbiLBhxu471LUsdDD63XZa9ADnJQN089vUZFaSc6Vh3iejysuiaW7FU
 7uhHN1yULCxfJsZH9U2AkSprCAMXgJ65nFuoRuAVex7GpNevd1AyP2NOM.ihhrkl3AsgdCyadbt0
 W02nXqztvEvrMjsrFwibJQBrAJ4nGWr5h0akSmX34dDOlxEkyPc1mcWNHrJE.0s9h9n1sRu9hmTL
 VRBiWprF0PzsIK8Mmo.08NSg_Et4OCk52kidbZia3GJcznVz0VjerLAI0RkmqOFo2WRk.xIdzAoi
 efdX2n3zRSJyiJTQ48oJixUrj7FxoS9wplaR7t4ctnXdr5vNjHPZeSLqgZzDmOLX4trTEwWOFE1Q
 thZ.x61Ivivmeo9Sik0hqY.VsCHHmrhMm_PMGG1VwTPwWhn59Tl6fO_j_zEhymHPtMSXZLJDc0Ph
 jUsoDayuFJYddGOelUFGSMPbrYT9P_T9MRf8Iyqbx7oN4n0DC8GWDMAfb6gcFlBd_sCvf3IzTvRt
 2BVRoPBq7I1zggrgNjxuW_y2F5HouUPV69dEOF061YUoaW0fmGnu2iEcrpNIe7.Cl473JJcPIvVL
 TOCngx4SsgUGL8qYQHKhSJNw0j5BAlIDp5d.uVmteeFnHmYdPHov9x2b0HZCtrq9p2UwaHbVaSrU
 FsRL0RQluHxp0f2UhXYjqrUJV7Fkk3gAtaV0RjVRr_9BeR0l1LyV.Fp4VKCgj_rTSCa3enkJrRja
 Cf0WFKanBTdnC7xUmdElyKT2JT2ksYL3pg3thBGCDEfnrFK.VWn7ZVLWzIyKALg2fhKREnLYywIa
 yqt9SmirZfZQHuh9XkW.7sTuVR4lea8IKPuQGk7DTsCCYsPMhJbTNd4II8Mlxvd1Xrltq0D3l_G0
 Lwd7gr5vywClwAIUUJEY7mbxmi_PHQTdnJfpSlhE8i_4FYnkDgt5YOK0GmI8ki7uYyvEXXNez.Vw
 ktVwYc.qW9F6MiU8DbYxQkcHEtusrjEwxLlzHdvGamphIyT7jzJgej42M9m9IfK9a5FrjCeRNE2t
 m8_ODJgfyxMJqm4cbLHx7Zbd.wU1oBS9ZF7zT7QhWlAhcY7S5o1QkwOhDn3U0zt0d3Y.s.ilePul
 r1ZfjD70oJpjKBDTAmIBrl7XquFT5PpPWHSrI6DU_tWrbfRtQWLbGq9zKkMp26QOYOuJVS5QjVV5
 .Kz8mJAlw_4gvgmbPF2k16UdGUJmD0XtD1pyE8vNyXt4sLF3h3UxrNeN0BV7CdsWe3gbQ8HVJKKr
 kJW2r5DaT36p4n0ON5i.KEO1LHLmUuoB3RzkqvFMb0.Bb4i8m6.93.TmUfd_Im7wVwuZ8_uGJaLf
 _r3Q.wcanNgli35LRmg2S8wMpR1plfoqo6Q6_AfYV2pyxXH6mPaS1aYcKS5P.ZLE844gBuDflbCr
 ZGAj4h2ekwwTRDBJweLcZ8In4VOMH6GZz6n3_pLwipQTp5e3dSKPts53DZYMw1XcTHP9NaIotwU_
 f_xKwzHrSa3qCnVNUKgCuTiu6oFAEwepXgivRG80xuQz_HyjvEA5XkffnaRzj0Cvq1yrQIuKMMib
 HSIo1wL1anQNanUi8vImo0oanIM1iEXSXtrPy6V8a5CWYLLC4dqlkHxi71kpuxs9rKtvsqKW7qhD
 Wxy1UrcuKgFWgA3B8TLtUJKQuszSu8kI.qjQ0La7msYnHfHLFFofnsxoAnRuUUICzSMZT_v1vrVk
 4rb2joAcOGhUL0acXXAt2S6hg0khHcYk8IbyUQcQNnU.cuSHBvHNCSSnGOU3tBi7XFVCfzw2NGKS
 NecHIcgH17QABwSyyS53VJjzhHsRuDxaR4MGuOV8ovyAhEJ1vnCkT0fi9qIU_XQwuOjBhcp.pzBh
 kr5Xkjqr6CZbQJvhxTS8r3IQNqLLd9uc_Q3aynbYr5eHXiutnX7CIPd89o4olNZVkitlrE6RUGtB
 I7z659rXcNAGUPnNVGqe.c02IeI3MzzfIGzViNlCcx1euff1ki7qjCCvBjtKM.ql4_Q3WJU.52bk
 5D8F4y0okxgqgvNg6j3zhz6KkHyBchtOAxYd6fLgCbScXT4eig.zasRdC0lql.BeKO435hNYq0kd
 LjRyeVEW3fp6_O9nQVNqVh6DS6WOA68xrva6_Y11_X.J8.99_iwynRPnkaFL3siQVRwcRUv_7l6z
 ISA831TM_R0p6mWudN4NJn6xS5EMwMzTHSoWCm5I-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 May 2022 16:29:39 +0000
Received: by hermes--canary-production-gq1-647b99747d-ndj76 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 89f08076760c31b5e11091f02eb35912;
          Thu, 05 May 2022 16:29:36 +0000 (UTC)
Message-ID: <84b848b6-770a-7d2a-4978-5e758383f994@schaufler-ca.com>
Date:   Thu, 5 May 2022 09:29:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/3] securityfs: Append line feed to
 /sys/kernel/security/lsm
Content-Language: en-US
To:     Wang Weiyang <wangweiyang2@huawei.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20220505132301.124832-1-wangweiyang2@huawei.com>
 <20220505132301.124832-2-wangweiyang2@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220505132301.124832-2-wangweiyang2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20118 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/5/2022 6:22 AM, Wang Weiyang wrote:
> There is no LF in /sys/kerne/security/lsm output. It is a little weird,
> so append LF to it.

NAK: The existing behavior is consistent with long standing LSM convention.

>
> Example:
>
> / # cat /sys/kernel/security/lsm
> capability,selinux/ #
>
> Signed-off-by: Wang Weiyang <wangweiyang2@huawei.com>
> ---
>   security/inode.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/security/inode.c b/security/inode.c
> index 6c326939750d..bfd5550fa129 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -318,8 +318,20 @@ static struct dentry *lsm_dentry;
>   static ssize_t lsm_read(struct file *filp, char __user *buf, size_t count,
>   			loff_t *ppos)
>   {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	char *tmp;
> +	ssize_t len = strlen(lsm_names);
> +	ssize_t rc;
> +
> +	tmp = kmalloc(len + 2, GFP_KERNEL);
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	scnprintf(tmp, len + 2, "%s\n", lsm_names);
> +	rc = simple_read_from_buffer(buf, count, ppos, tmp, strlen(tmp));
> +
> +	kfree(tmp);
> +
> +	return rc;
>   }
>   
>   static const struct file_operations lsm_ops = {
