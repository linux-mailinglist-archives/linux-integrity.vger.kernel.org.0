Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707E32699F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 20:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfEVSNc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 14:13:32 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40849 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfEVSNc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 14:13:32 -0400
Received: by mail-qk1-f201.google.com with SMTP id n5so3027393qkf.7
        for <linux-integrity@vger.kernel.org>; Wed, 22 May 2019 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KM7CjYDnjAV8QyJ0hTISAOThnGytkQzTdcUAPgNxHfM=;
        b=Y5z/WrwYn/EevSOX0UJiI3pTm79+b38nXRuQIjSPRPPtZoTDiPsMytdq7iob9D0w9f
         iwsOjb0GO+qtEvuwjAadHLu376vLFtF6HtMYNozmhqgLwhqLHOSR3U+obcwfGbrmT/Fp
         yypOW2Z+nnGpFLTcfP4VyrVUblTXsqpA16cINoxGQLweOo14VP9C6qijmh6zSzAdFnxC
         gekeZeeHYml7yXaozy4Ty9OGvakpv4A+yc6NvPlndPIEKEDfL5uCXSc7gxM8V3bSIRXR
         484qlx/LOcBFhwYzLlczMtjo9qs4id3CpE8tx0OpumdNQz75mFWypb9kCLWEjbQG1iww
         k3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KM7CjYDnjAV8QyJ0hTISAOThnGytkQzTdcUAPgNxHfM=;
        b=PVGLnAlk4bbRCRi18eUU8Uph5PjFvey5Nf9n7NJpQT3HRT7MvHJCjnMfW397PiRwLC
         nh0uqWI35QcuByaFAfQt3sPBwJmxb/icBgVSrGqFG5LCWvffeJoapIw9COgKLYdkthsb
         a6hfy3bygIOEzrEfUlKhCyDEjzpKN9rny8C+AJmGAxLGKwhX9iDmVqCtU/ZVT0uoIc2x
         vUsfIbiX8VDQCKBPovNTY7q3oSOOwYCI4eYxVmbOnGGnuIa9h6kscYqTY9SxPeDyfmkp
         XmhqZeFyM678nN/ZQ7os25kdH8F6rjQuJjsCqNuM+8nolII3MimfJ7jNRqHAp4FnZlOp
         0fCA==
X-Gm-Message-State: APjAAAWtyblGbNI8w84cFTHdKT3owY5+z4rQcpCQjXmtML4vE0i8DXK8
        hDi66IndBucgk5anp8EKllfq11+zrxG9vqOFZVg5qnvn2XQWDPvdBLtRpgiZR5/PTzg4YPQkk9W
        QhinMTGWTVYU3zgmyUDCXlyaZZUZeE+0vMK4WV+L8dMbfo8R31HEBJIvGasYP4caBaGOKFCFx1J
        N/S6CJzxKA7f8yW1tSLOI=
X-Google-Smtp-Source: APXvYqxN9lF7zFmmORjY6HkdCGmVz+pn4sDp4LmILIpJctBkILss9FWEm4q8eSZUPXj+yg58aSm6E1fmbC115ww68LQIUw==
X-Received: by 2002:aed:3e69:: with SMTP id m38mr75792403qtf.101.1558548811124;
 Wed, 22 May 2019 11:13:31 -0700 (PDT)
Date:   Wed, 22 May 2019 11:13:22 -0700
Message-Id: <20190522181327.71980-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V4 0/5] Allow FUSE to provide IMA hashes directly
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dropping the final patch in the series to allow independent review,
otherwise identical to V3.


