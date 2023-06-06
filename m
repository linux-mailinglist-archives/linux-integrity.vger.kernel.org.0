Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0135723D1E
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jun 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbjFFJWc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jun 2023 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbjFFJW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jun 2023 05:22:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BFEE55
        for <linux-integrity@vger.kernel.org>; Tue,  6 Jun 2023 02:22:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-978345f3798so166272666b.3
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jun 2023 02:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686043345; x=1688635345;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A2ESXYQhltyj7fjwwg8HklYOExEwSWjFcjtOKFaoW/Y=;
        b=Kpo9vPuy/MsTRfwwvxVa59D9vXquTWupJ6pHAucRUU5vzwo95I+Ti8nOJC5L2VPMR8
         yC4OMHZ6jZVdZpJUOwNjIB1msEXiR2X5qI0A3RbptKORkaZN4mj6zXINim0FGS5W9jFh
         x8d+LXORwPjRUDoC8kU5zdXkKKQ3sPFcRWmP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043345; x=1688635345;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2ESXYQhltyj7fjwwg8HklYOExEwSWjFcjtOKFaoW/Y=;
        b=D7TD4IDQK+SXFKqvAv8vIooQWMhwIlQk6YrDm2y038RWe/qy8PsdcWvzgKILdQCOMq
         9aEb/fA+BDD9aa6m8sElckIUb3ME273Am/INxFbU8+nxW8NGh0LPuGyPA9qPiSfp32dR
         NPIccNQHd5IZII0c9211ndXU/9xcFc4U/2V5DXZUnPTJMSlqh5yjkH/scuipP7hYCTZO
         D7V/hiZz3okTtxYY4uJ7Pl6M2dv8lKMFzzSOfvTGDGxNj6cVURW06/en+X93mOQGOUqZ
         bMnA230GXeUBauSCKSqs/rBNGxtGfZo0dJV9Pz0indJpPck3yrZg6HQzGOG9lXm2NcGn
         3tMg==
X-Gm-Message-State: AC+VfDzbZqWmY7n+ZQxnTpqFmTl8BqVKRGz/M28Km+IXg0c9oAoiiP1g
        oWaWcYlaczYnG1X69hyopUGXOqaXL9Gyc7vge76FKg==
X-Google-Smtp-Source: ACHHUZ5BbL+fkVjUDRt/CLDWeUDkrLxoMh0slW44uxEA/AoGJbJQoxFpILPG7FR44riSIZdNkYsgQvpSOiv6GwiNCww=
X-Received: by 2002:a17:907:7baa:b0:96a:30b5:cfb0 with SMTP id
 ne42-20020a1709077baa00b0096a30b5cfb0mr1987499ejc.22.1686043345046; Tue, 06
 Jun 2023 02:22:25 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 11:22:14 +0200
Message-ID: <CAJfpegsoe_2fiFB9fw3wCtaMj6qQqB-8Xi801ZB9Ye9_gYrJpQ@mail.gmail.com>
Subject: Re: possible deadlock in process_measurement (2)
To:     syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

AFAICS, this is a duplicate.

#syz dup: possible deadlock in mnt_want_write (2)
