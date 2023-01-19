Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E37672DD6
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 02:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjASBLP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 20:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjASBLK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 20:11:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9294DBE5;
        Wed, 18 Jan 2023 17:11:06 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q64so833184pjq.4;
        Wed, 18 Jan 2023 17:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a6gTHxnHocG3EOjYSvHjeImOH2TijHK1E3d9yPNEYQ=;
        b=phIf6/oVhIVYz4XdxQX6EJsCbt+WRAp+joMADi1BqdUXnenACCmvM2II1ts8tHedta
         IDVO7pOgGIdscv/FK7t7kuYHQP0eeD0MORf/nB+fvdPcBBaDPw/ESCWVqOifC05Tp1JK
         YU4F2vxmLV+QRAzlMoFVFvG61YOlBVnVR1tcPpzwgMWfdWIgVd/DPGjhQm3XTs1QEgv0
         S6g5EWoFMlwRDC4ZB8AsZkShd5wRa+xaSEBLvTtbH8HQHfVj5zFrT4JCrddUKED36PDS
         qvnjAFHJrEybbbXwEvkl3liIBAw/jN1EyGaCxAbn/m/f33Nq3i4s+r0FGjSkykMDrpN4
         CRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4a6gTHxnHocG3EOjYSvHjeImOH2TijHK1E3d9yPNEYQ=;
        b=1nmPQIndgFRw6/os6FxiE6MouQBA58dFYgrNEAHBM/cezNJGwi1n90KwqbAfc8TDmx
         CTEhHlvFtfnvrZylurEmKRH4yLZItJBHTWsRfeq2Sj+AYi3jUhpga1TkFA+xP3imBmTk
         pBjWVdSmIfPww422hetWu4RuLYYamkGcElETqZXMGqs/vb5vT/dmfIsfOUamTdNtaqJT
         6iK0Jw5eSdDJuIfSUfBNEIRvcqy3QHeH2/puXlnMeYpHJMc95qZLyir1S+Yzhwl9JLyt
         DDxpfHiE78bOr+b9M0XvRCw1Oy7AyWTD5An5GTPejOSk/9zUptn9SOr9lB7QhSl6I42P
         XBqw==
X-Gm-Message-State: AFqh2kplmgfvWfPHjiiZdvkABnWAtdbxBk9BdJmrrlMmBfBqfMZiVcuZ
        5A/JAtY4aVg5bhdMaqjaK8Y/A0QQKR0=
X-Google-Smtp-Source: AMrXdXuEr0AenQQTGRZxGOq8GuW0YuV9eCnOjJcK3F9GgIwX5FOJ0fljJqUR5ShuuHuaNrrsEqyxgQ==
X-Received: by 2002:a17:902:e5d2:b0:191:3808:14b0 with SMTP id u18-20020a170902e5d200b00191380814b0mr12887306plf.4.1674090666075;
        Wed, 18 Jan 2023 17:11:06 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0018911ae9dfasm23675468plb.232.2023.01.18.17.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:11:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 11:10:58 +1000
Message-Id: <CPVRLZNI6WWQ.1AZVH3NCPCOYL@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>,
        <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 08/24] powerpc/secvar: Allow backend to populate
 static list of variable names
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-9-ajd@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-9-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Jan 18, 2023 at 4:10 PM AEST, Andrew Donnellan wrote:
> Currently, the list of variables is populated by calling
> secvar_ops->get_next() repeatedly, which is explicitly modelled on the
> OPAL API (including the keylen parameter).
>
> For the upcoming PLPKS backend, we have a static list of variable names.
> It is messy to fit that into get_next(), so instead, let the backend put
> a NULL-terminated array of variable names into secvar_ops->var_names,
> which will be used if get_next() is undefined.
>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> ---
>
> v3: New patch (ajd/mpe)
> ---
>  arch/powerpc/include/asm/secvar.h  |  4 ++
>  arch/powerpc/kernel/secvar-sysfs.c | 67 ++++++++++++++++++++----------
>  2 files changed, 50 insertions(+), 21 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/secvar.h b/arch/powerpc/include/asm=
/secvar.h
> index ebf95386d720..c8bee1834b54 100644
> --- a/arch/powerpc/include/asm/secvar.h
> +++ b/arch/powerpc/include/asm/secvar.h
> @@ -23,6 +23,10 @@ struct secvar_operations {
>  	ssize_t (*format)(char *buf);
>  	int (*max_size)(u64 *max_size);
>  	const struct attribute **config_attrs;
> +
> +	// NULL-terminated array of fixed variable names
> +	// Only used if get_next() isn't provided
> +	const char * const *var_names;

The other way you could go is provide a sysfs_init() ops call here,
and export the add_var as a library function that backends can use.

Thanks,
Nick
