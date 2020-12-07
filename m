Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C791E2D09C8
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 05:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgLGEnk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 23:43:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbgLGEnk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 23:43:40 -0500
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1km8MT-0005Ed-Vh
        for linux-integrity@vger.kernel.org; Mon, 07 Dec 2020 04:42:58 +0000
Received: by mail-pj1-f71.google.com with SMTP id o19so6483215pjr.8
        for <linux-integrity@vger.kernel.org>; Sun, 06 Dec 2020 20:42:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=dRTRoGxZQjf5VfvQ9QuIyncdiTUdvBDf3dsatRDVAPg=;
        b=dTjQcePeB5641oPYu8RYtO45X6Ojtt4sHZWZPun3JhwybemSWlh8KUWpVYBAoKFFpU
         aip0/c5T9ygQrTWWQsdasYUQSLN7pCDWEHNvVC8vJw+OUFAulRmJ9Kwsa5BTnOj+bD1L
         Lr3gNwwlRzeYY0v+9CKiCnQnFxl2d2auv8IrXQ+LcfTUzf8zfGQTYRd/91uG3ZeVw9wi
         y4wf5aWXcSl46PoJpJBvQpyAMfCksodCmLo+Eix7IweD/GdqajmtR8nJ6xTKR/6VMccp
         ko5K3sKW73n5+hbZjJVigQgaSGFE8cQF4uCsZOUKQBO3g+uLYQ0xUcHoM0Zn9s0hArRT
         J1FA==
X-Gm-Message-State: AOAM530RP4mzgSO8Z41xvjsIIPcnghyZ155k8kwghMy2+UveX3Syumu1
        voST9Xex10rMLVfMkYjucPL4/2fhcnY2X5Zo4Mc/d4Qeyio03gRAOpDoL1ULcbycHcQxEf6yoe3
        QZrj5JT5elXh5HtRabIOKNGXGDcVo61PLwBH2S1WxdkgliA==
X-Received: by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP id s186-20020a622cc30000b0290197dda8476amr14074266pfs.37.1607316176710;
        Sun, 06 Dec 2020 20:42:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcuP2lNMdUlH6UM9n5vr/FUv5lVhwMXHQSz4F1MIyvm218sS3P3QzvWgVdfMzSLSxeSqIrNA==
X-Received: by 2002:a62:2cc3:0:b029:197:dda8:476a with SMTP id s186-20020a622cc30000b0290197dda8476amr14074254pfs.37.1607316176412;
        Sun, 06 Dec 2020 20:42:56 -0800 (PST)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id q35sm8987011pjh.38.2020.12.06.20.42.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 20:42:55 -0800 (PST)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.20.0.2.21\))
Subject: [Regression] Can only do S3 once after "tpm: take TPM chip power
 gating out of tpm_transmit()"
Message-Id: <7E60C7F0-85C6-4A9A-B905-904D37A5E67B@canonical.com>
Date:   Mon, 7 Dec 2020 12:42:53 +0800
Cc:     linux-integrity@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.20.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

A user report that the system can only do S3 once. Subsequent S3 fails after commit a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()").

Dmesg with the issue, collected under 5.10-rc2:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/14

Dmesg without the issue, collected under 5.0.0-rc8:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1891502/comments/16

Full bug report here:
https://bugs.launchpad.net/bugs/1891502

Kai-Heng
