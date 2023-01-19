Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80636672E02
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jan 2023 02:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjASBUF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Jan 2023 20:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjASBS5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Jan 2023 20:18:57 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC076C562;
        Wed, 18 Jan 2023 17:16:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so830907plw.11;
        Wed, 18 Jan 2023 17:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbDZxGDp8FFFBhm3skdTuca0wCb1RqhnA6hZ3TKJit8=;
        b=m91VX7/3DOiTpb7lvJW92AF59U5cpWwU6ggAKRCUGvVcfgSWDB9SQEa4+AuPlc/ug6
         +XMf3JArGv1o8ktY842QajeWbV/9MtDIPqUVISTALLYEej2cRWueeCdyZqKIoeKaNj49
         fLQKEfWJ7p9SyMwlRlIPGxLzozGjLQ5CLA52smpT2EQjxEXNKCqldz0hb+m+igeKsRF9
         khQAWIW34B+51/9Y1W7A+zc66C0mOSmHQbeKN2wWM7vC+dy+v+eWp7nrHZMwvjufIgj5
         xxtifri2RM3VciVmBbf7F6HY88isNfLKYnDQkgO30fqIq+qxPmJJJwjeaprz+nbKxuqh
         xrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IbDZxGDp8FFFBhm3skdTuca0wCb1RqhnA6hZ3TKJit8=;
        b=J6E0hbGv0AYzO2tNpN6rEaK0BSyR4mqya6LRZcNtsmsikurxgNPXFp5nM/fIQ8lr2n
         ncWMf9bZBoRBzkfvTgXTpRv83QsA1jatj9eR9RjcG6mOJ21hA8Bce1tOL2O9sGOfSyuh
         OLasYOYMLmqO0h2ASL4xm+gxbAdDquVEjj/JsR+VxZu97YPBgPjG4pr6ck4HtegAv5lf
         m9UmrU/bS6g17bGJ7nIF8UOSQ7DaY2lqW2/ndnvQ0RRn2/LVPIGQxzFC43Rfaa1G6Eop
         qs31ySzJisJPqyJdggx8EJP4wVmG4F+yUskIbmJsNvEIgT4Zz+zu+9vhQ6J2BEC2yYYp
         0PTw==
X-Gm-Message-State: AFqh2kqNnlU3V+xSBZR29MvrSEu9ZElFOP5QKQEEDJs1hUjLkR8vS2ch
        Oh2EKZSI/DYTuUOJn7470Jw=
X-Google-Smtp-Source: AMrXdXt1QQNOAQpB1Kri+S7V27/Xl104ByL7t0pHQAj/LRNQdRDTMhaBvcDcOaq3Ci4N5vVEYOpbvA==
X-Received: by 2002:a17:902:7209:b0:194:73c4:6bdd with SMTP id ba9-20020a170902720900b0019473c46bddmr9728122plb.17.1674090961806;
        Wed, 18 Jan 2023 17:16:01 -0800 (PST)
Received: from localhost (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b00194a53ab3e6sm4235447plt.286.2023.01.18.17.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 17:16:01 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 19 Jan 2023 11:15:54 +1000
Message-Id: <CPVRPRLUQYA6.VGAMPDLW043V@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>,
        <gcwilson@linux.ibm.com>
Subject: Re: [PATCH v3 13/24] powerpc/pseries: Fix handling of PLPKS object
 flushing timeout
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230118061049.1006141-1-ajd@linux.ibm.com>
 <20230118061049.1006141-14-ajd@linux.ibm.com>
In-Reply-To: <20230118061049.1006141-14-ajd@linux.ibm.com>
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
> plpks_confirm_object_flushed() uses the H_PKS_CONFIRM_OBJECT_FLUSHED hcal=
l
> to check whether changes to an object in the Platform KeyStore have been
> flushed to non-volatile storage.
>
> The hcall returns two output values, the return code and the flush status=
.
> plpks_confirm_object_flushed() polls the hcall until either the flush
> status has updated, the return code is an error, or a timeout has been
> exceeded.
>
> While we're still polling, the hcall is returning H_SUCCESS (0) as the
> return code. In the timeout case, this means that upon exiting the pollin=
g
> loop, rc is 0, and therefore 0 is returned to the user.
>
> Handle the timeout case separately and return ETIMEDOUT if triggered.
>
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStor=
e")

Can fixes go to the start of the series?

Thanks,
Nick
