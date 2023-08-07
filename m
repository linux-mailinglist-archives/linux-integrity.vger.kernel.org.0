Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6A77305F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Aug 2023 22:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHGUfa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Aug 2023 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHGUf3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Aug 2023 16:35:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E86910F6
        for <linux-integrity@vger.kernel.org>; Mon,  7 Aug 2023 13:35:28 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583f036d50bso56628257b3.3
        for <linux-integrity@vger.kernel.org>; Mon, 07 Aug 2023 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440527; x=1692045327;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=WGuPu7g6E23RXr1v5LnKJEwl5/NhLHAEmhF1044iAo3zlPa7q/dCiC92JtWaTvN7LN
         bVXSSjM+IWwdQf1AGsnUhtt0TLD2CCmfvj8Sjsh3wWo6GyC8KlsMejMvV9iNlMpUx9m1
         e/eijDs1mEJFLO2TJBkN14g3t0J7/HRjYHt6jGqkdngI9wph52Q3ogRxNMdKAtzxeg25
         XcWL+ONayv2a0pAGg3swXgiokEXA9gilyRGOhIKTk6x9SVYmEuPxsePgRyIfDvwxlOgo
         +P+p48B+fjlmlUQjs4uiEbdAC7avrSnparZrobMq0G7U0aWx0KuTlGpL6KaJ4cD3tzP0
         zoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440527; x=1692045327;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgsQjPYSA4x9EUAST26pLIMgzwk5/fmUNEDBBVE+P4A=;
        b=cBwJtv9Rhg5izgbh7GwT1/UGLr7xnlocPNVeXbp5jRI6xeV11G+PFvSwOQEqFozzg8
         3qPSlPcPzXaLxNiCSzry7hotoHdDq2it2LF+Xgb30RFPeku/xYzlespqcE6deOn8i6wp
         hHKSxoR5tWRp+B2H+O8VUnoMSqxQJCi4HDwHqETTbdJUf6LZG7FN0ztNVG19L+i7TrAA
         CSfQdhIl/Y0GmyDvQao6lbY4w6umBhXLBgnfho3hlk47hbTDleYbiOXt4EVMI2AmAfKG
         NmE2SxWVfW9Hb07KF7lORiFgavF32qFio+MGFgy0xxu7b99sk1VGa+vdAZNPfLcQcBUG
         D1hA==
X-Gm-Message-State: AOJu0Yy8Y2+6XKzbncLLWSaO39HJmGodbsrHZ3zSyKQyNIHhVpJjrzwW
        L1ao6/aqfUSlKIAGmdYa6S0GRwu5muEBOWXMQu8=
X-Google-Smtp-Source: AGHT+IH6RhdoplRqECcY8mUnEMQB3kKUONmBVdu9pLDcOmWR/5QFK305l7kYojCsuoKgbwfz4sV69GprXYw/1zMEwFI=
X-Received: by 2002:a0d:dfd8:0:b0:56c:e706:2e04 with SMTP id
 i207-20020a0ddfd8000000b0056ce7062e04mr12209481ywe.0.1691440527025; Mon, 07
 Aug 2023 13:35:27 -0700 (PDT)
MIME-Version: 1.0
Sender: lw466553@gmail.com
Received: by 2002:a05:7108:160f:b0:326:a9e:5940 with HTTP; Mon, 7 Aug 2023
 13:35:26 -0700 (PDT)
From:   Dr Lisa Williams <lw4666555@gmail.com>
Date:   Mon, 7 Aug 2023 13:35:26 -0700
X-Google-Sender-Auth: 0G1lXpJv-q7nK9NDmCu4G39nQek
Message-ID: <CAPHeqezXrZjPmETqsqybz9ND0xuLHy7Yn1jh0fx-tfjmjnpqCg@mail.gmail.com>
Subject: Hi,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

My name is Dr. Lisa Williams, from the United States, currently living
in the United Kingdom.

I hope you consider my friend request. I will share some of my photos
and more details about me when I get your reply.

With love
Lisa
