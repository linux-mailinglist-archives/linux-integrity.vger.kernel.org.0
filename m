Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2907247E1
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbjFFPft (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjFFPfs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 11:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1448A6;
        Tue,  6 Jun 2023 08:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673006350F;
        Tue,  6 Jun 2023 15:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CD9C4339B;
        Tue,  6 Jun 2023 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065746;
        bh=QX2hJhXvR07WNQuH/Vadqzi2C83Wm8fOdLqApveKaFM=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=WH/054Ab6Lm8tTx35Ey6+bvToXiLSjhUlgmfrfGPs+sh3SHvQ8rPVsy2C2EYJWsBY
         uHvw8chkYWWtVxyI0hStWsY3L1SBZfp5LNqKoxQBhqgRI1KkVUwnDd+QNX5vwZu55j
         Z1SuPhWeEW5eVFaI1LJ9pYXfcPCSIWJwScAkA/cdzso7laLXF7voSBVmId8xiBdSJM
         U/z6TLam9tCe8/cmTyUG7RMYbgsl+aZoKJLdwqh7aQci5xLvOqf8VOoTPS+ADR2A1V
         jFe5g9PMwnxVzfi0ToHNpmamYza/DuCflsCRIZg67JdKuBqeSZCDmpzuDVYX0tDxPp
         V/4SZKNCHy31Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 06 Jun 2023 18:35:41 +0300
Message-Id: <CT5OF8SU9ZVZ.2HMX7ADFOL8LG@suppilovahvero>
Cc:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [PATCH 2/2] ima: Fix build warnings
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
X-Mailer: aerc 0.15.2-33-gedd4752268b2
References: <20230606074113.2120632-1-roberto.sassu@huaweicloud.com>
 <20230606074113.2120632-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230606074113.2120632-2-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jun 6, 2023 at 10:41 AM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Fix build warnings (function parameters description) for
> ima_collect_modsig(), ima_match_policy() and ima_parse_add_rule().
>
> Fixes: 15588227e086 ("ima: Collect modsig")
> Fixes: 2fe5d6def167 ("ima: integrity appraisal extension")
> Fixes: 4af4662fa4a9 ("integrity: IMA policy")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_modsig.c | 3 +++
>  security/integrity/ima/ima_policy.c | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima=
/ima_modsig.c
> index fb25723c65b..3e7bee30080 100644
> --- a/security/integrity/ima/ima_modsig.c
> +++ b/security/integrity/ima/ima_modsig.c
> @@ -89,6 +89,9 @@ int ima_read_modsig(enum ima_hooks func, const void *bu=
f, loff_t buf_len,
> =20
>  /**
>   * ima_collect_modsig - Calculate the file hash without the appended sig=
nature.
> + * @modsig: parsed module signature
> + * @buf: data to verify the signature on
> + * @size: data size
>   *
>   * Since the modsig is part of the file contents, the hash used in its s=
ignature
>   * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 3ca8b7348c2..c9b3bd8f1bb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -721,6 +721,7 @@ static int get_subaction(struct ima_rule_entry *rule,=
 enum ima_hooks func)
>   * @secid: LSM secid of the task to be validated
>   * @func: IMA hook identifier
>   * @mask: requested action (MAY_READ | MAY_WRITE | MAY_APPEND | MAY_EXEC=
)
> + * @flags: IMA actions to consider (e.g. IMA_MEASURE | IMA_APPRAISE)
>   * @pcr: set the pcr to extend
>   * @template_desc: the template that should be used for this rule
>   * @func_data: func specific data, may be NULL
> @@ -1915,7 +1916,7 @@ static int ima_parse_rule(char *rule, struct ima_ru=
le_entry *entry)
> =20
>  /**
>   * ima_parse_add_rule - add a rule to ima_policy_rules
> - * @rule - ima measurement policy rule
> + * @rule: ima measurement policy rule
>   *
>   * Avoid locking by allowing just one writer at a time in ima_write_poli=
cy()
>   * Returns the length of the rule parsed, an error code on failure

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

