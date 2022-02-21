Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0914BECA5
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 22:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiBUV2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 16:28:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiBUV2Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 16:28:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B3E26
        for <linux-integrity@vger.kernel.org>; Mon, 21 Feb 2022 13:28:00 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s13so669924wrb.6
        for <linux-integrity@vger.kernel.org>; Mon, 21 Feb 2022 13:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cerclemallorca-org.20210112.gappssmtp.com; s=20210112;
        h=from:reply-to:mime-version:date:message-id:subject:to
         :content-transfer-encoding;
        bh=AXmZL+QmEVFFHXkVJC5EhgsSrXJb9VIQQRIumXYXRMg=;
        b=RldetFlCCJx/QdKRVlH+TF8wtCgJt4kwFfqitq0CRlytYVa4jE6DRUPSNsE0jgEny3
         VSyUO2lQBpXWYyWqVrJmAlqHgOByvGStpzqWEJWS/PgV8tVksAf1k6rOOAp8fF+4bEWx
         REiKa1EplKIYoX9xUJKqxgl25DgSjVfIY5tbsiyERDqdxyDnp0JFp6Y9r9i/boPrPGos
         wi3nOmkK9oJo82vQ51FIMI2uNnzedWXi37L3r5YTkPA5lK6sEvS7ezT+p5cuDPyowwtN
         PLDRGer+J4EO9PqJT7wytpJWivZvCuYfp9sotUnBi7sBMf7E+g+Y5rCRpOI7HbLZuDxN
         u5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:reply-to:mime-version:date:message-id
         :subject:to:content-transfer-encoding;
        bh=AXmZL+QmEVFFHXkVJC5EhgsSrXJb9VIQQRIumXYXRMg=;
        b=XM/gVjzaqMuxh213PilO9JYCvmyKgJodZOXYMNGj87tf7n/qL5qbz5Qc5SHVlAKOKR
         WYlNgyCogI7Tu4j7FgMX64NBwZL7EXC2vaJRxh5fF90mnv3mGWIT0KlcFjL76XZoruiZ
         C5YntI8G3bed9pZ9I4jyh39HlC1GZyCh+InFrUKYO8pSCQnThC/6pLM0pTXq+7OYjk5Z
         7XjLZelymw36MadAiMR3O/zG++pumE5frxle58tubC+mmrN4orCyftxsOlqq4ymFDJyl
         Z4qfokiGdAHFv2q4HFFHIsE/7NsEsjv/3sz67iHe+tK/kqC37kDiwkud9ZX4mAh8hEdn
         uXxg==
X-Gm-Message-State: AOAM532M0FD3RyC8myg3Bifmj9y2LyQHXn6iPmqy0jPoABwrP66u+q5A
        C+WGWNgTcgWuzxC7otrnSMK6y8bDTVTJugTGJsovuYoDJi8=
X-Google-Smtp-Source: ABdhPJyom6dWD+D4uQJ5A5IdlZLgjrviNh2hryCYPpMEnziqbLzxCk3hRCoOsk5Ohp4z5zmwjPRaxuy3rgyhmn8/XxA=
X-Received: by 2002:adf:b608:0:b0:1dd:ef47:5448 with SMTP id
 f8-20020adfb608000000b001ddef475448mr16754943wre.243.1645478878947; Mon, 21
 Feb 2022 13:27:58 -0800 (PST)
Received: from 729955949434 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Feb 2022 13:27:58 -0800
From:   =?UTF-8?Q?Cercle_d=E2=80=99Economia_de_Mallorca?= 
        <tic@cerclemallorca.org>
Reply-To: cercle@cerclemallorca.es
X-Mailer: WPMailSMTP/Mailer/gmail 3.3.0
MIME-Version: 1.0
Date:   Mon, 21 Feb 2022 13:27:58 -0800
Message-ID: <CAN_rQh5er-oPSzwgggMAKUM8Bs3en_ZKqubXOrDgPULeEnEYiw@mail.gmail.com>
Subject: Solicitud de socio
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Buen d=C3=ADa =E2=9D=A4=EF=B8=8F Ella liked you! Click Here: http://inx.lv/=
6BUR?n7us =E2=9D=A4=EF=B8=8F e8gf01m:

Hemos recibido su solicitud para ser miembro del Cercle de Mallorca
Si tiene alguna duda puede contactar:

971 71 71 67
cercle@cerclemallorca.org
