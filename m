Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D864C14B5
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 14:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241040AbiBWNvV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 08:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiBWNvV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 08:51:21 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B2B0A45;
        Wed, 23 Feb 2022 05:50:54 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2d646fffcc2so211640547b3.4;
        Wed, 23 Feb 2022 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pKo3y5pdjYFiqVTkRzmPHLixA2iXhc/brT5RC6cQ7/U=;
        b=QrOOZp6kxM6BNCBV2U+l710IUCPOm0sieRmWivgPcpiWIIPq6lNEWgx5P4zXWEloym
         SW3NZ68AdWRqXNvs8IN71g3gJca1+G/iSYDyBLIXz3/PlPe1pdwy6Lg6BcTB+nVEh+Lj
         eZHyiyNZqtD4bzOQVA5QPWbVMvdA9EZkxPyo5WHLB7W/JSiksIT8ADrHNQW9er/jUHVg
         AFBa5c8iRvy+b8L9InthkGN2vV44D6fNkRuLGEgKaRJxBfhpmx00Y3eJaZqp7YfQhVvI
         nM9+yS6gxuXpkFnBU1k1mPBf87HoEe884TdWwPCSFKGGZ5uPCBWXphu+zEHq/wDubYyg
         q2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=pKo3y5pdjYFiqVTkRzmPHLixA2iXhc/brT5RC6cQ7/U=;
        b=KpPhyw89uIxeu7UKKK91Q3VI/9Jn+QkGSO6fTMo4M85FekcFuoRKKXISvrxByOR5xD
         mEDbz72Hzbt0JsJFnxMhkRlZm+iiXnOirZRcqzuKx/V3aPumtRrBEQUrQ0IKwYFlmPVu
         Q9sL4DCwdDLeqb6J30f487eW8vgU+2KZf6QlNqB7UuYq38p96fLV6z8difmlRx0vbX8y
         Tu4wBfZy1Q0Mt69ehYYJ9iF97s33VH9hJcOPXEkp9AoTz/Wg8Ot5JNsXHl9C8qSJuc3F
         cQfQAziOEolss9muuG349zMG1faBupxbii8KYqvCLpGZlkmei53ZWvyCFxGGDI16eC+G
         UrPw==
X-Gm-Message-State: AOAM533fGpFBvc3KdTSpdjNlQ2gxS/JodPdlvct1vZZRtp1wQCJc1iG4
        3DnslXCI51LbOzWk2BYyQoGKB3HBBJIIznC1EBM=
X-Google-Smtp-Source: ABdhPJxImkdAaBnYftSPEPG3iRGw/kDbrLWHIc5vcgcHvBc0zNc/G27s5IK0BcaoJqjbTN4JoLBUDadS0pxVkezuU2M=
X-Received: by 2002:a81:fc06:0:b0:2d6:4a8d:943f with SMTP id
 g6-20020a81fc06000000b002d64a8d943fmr28893053ywi.464.1645624252626; Wed, 23
 Feb 2022 05:50:52 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 23 Feb 2022 14:50:42 +0100
Message-ID: <CAKXUXMwrvq=aDWcZRKk-0UEiKQtywDbiVSJnsxnAc_sBoSNY6w@mail.gmail.com>
Subject: Unintended file entry addition in commit 7ed88a03b15b ("certs: Check
 that builtin blacklist hashes are valid")?
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Jarkko, dear Micka=C3=ABl,

The commit 7ed88a03b15b ("certs: Check that builtin blacklist hashes
are valid") adds a file entry for scripts/extract-cert.c in the
CERTIFICATE HANDLING section in MAINTAINERS.

Hence, ./scripts/get_maintainers.pl --self-test=3Dpatterns complains:

  warning:  no file matches  F: scripts/extract-cert.c

I could not see that line being added in the original patch, i.e.,
https://lore.kernel.org/all/20210712170313.884724-3-mic@digikod.net/,
but it was only part of the context of that patch. In linux-next, it
appears to be part of the commit above.

That seems to be introduced while applying or rebasing the patch to
some later version. If that is the case, you can probably just drop
this line "F: scripts/extract-cert.c" in the MAINTAINERS file.


Best regards,

Lukas
