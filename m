Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6C7D704A
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Oct 2023 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJYO7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Oct 2023 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344016AbjJYO7b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Oct 2023 10:59:31 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABDDC
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2023 07:59:29 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so2222635e0c.0
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2023 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698245968; x=1698850768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYQ3okT5d3Nr7vbYAmBVtOHd+MxXyv8cMuIfiU00t8Q=;
        b=k9LuhC8utHiHVdo8FxNHJ/oWyVNKWqsXLh3sCWCCqEZgBT5aEqZnFDzonvxqOFEg5q
         UUAs8dUTs8o7QC6HWdRqTNyAsPHmklsq26BSNT9ZyELYIMhciUwK6+YkE9vSakWmISX3
         E8lNh1ngirnhKG4B1RjMHeasWD1Vte5NfPjGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698245968; x=1698850768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYQ3okT5d3Nr7vbYAmBVtOHd+MxXyv8cMuIfiU00t8Q=;
        b=lXpgrTz9UDC0cE0ZFu8dS37SvgAx6mSJrzrMZKuZZNOdANu8R9mMTuGPbHhHozmaqt
         KyhXOpUOdGCUicmlXT3UganBp8HhTNsjtuKIX1O4TSdB0i/XyANOpuheBDqbENolBEMh
         ehGez82fyb5QOYAS+BM11MQURtS2uqFMKK7IG2sJNl2/hpe3ffEhg0Wb3dLM5Xlt6kv9
         TtP+zjheHWV3DEvoGaIRQmmniwhbQ87jS8d1c9nHDiZnTSRPEfao8jmGP6atGoHtj9qO
         /GwSUxiUJSApZMejazsWhdPnSy7PskcPa6Gms+vEKeHdjtYsB4+aRPTZZAeg/UYG7zto
         gxyQ==
X-Gm-Message-State: AOJu0Yx15LDLVk+2ij+CG7L05HWyJeThZMkcxmZV9LN6TElXIi4VlPWE
        Co67rlpRZM1TShraT4JWhVtENCPFVHwF3AKRrN8=
X-Google-Smtp-Source: AGHT+IHI/DrZn37oro9HlyZLu/DU5faMwMNB2/t3Q3xJLLz7IMjv1WfjfM8RJhexNXd0jjXEVlttkg==
X-Received: by 2002:a1f:9e4c:0:b0:4a8:d86b:9fd0 with SMTP id h73-20020a1f9e4c000000b004a8d86b9fd0mr3812124vke.3.1698245967975;
        Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id r10-20020a056122014a00b0049d28bbb8e8sm2027vko.32.2023.10.25.07.59.27
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-49d0f24a815so2208234e0c.2
        for <linux-integrity@vger.kernel.org>; Wed, 25 Oct 2023 07:59:27 -0700 (PDT)
X-Received: by 2002:a67:c190:0:b0:458:8ef9:a27d with SMTP id
 h16-20020a67c190000000b004588ef9a27dmr12269216vsj.20.1698245966786; Wed, 25
 Oct 2023 07:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231025143906.133218-1-zohar@linux.ibm.com>
In-Reply-To: <20231025143906.133218-1-zohar@linux.ibm.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 25 Oct 2023 08:59:13 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
Message-ID: <CAHQZ30BSD2c4WwUTARx9OeqTjusgq7te8OzwdUi6Qk+L=9vSgA@mail.gmail.com>
Subject: Re: [PATCH v3] ima: detect changes to the backing overlay file
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 25, 2023 at 8:39=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> +               if (!IS_I_VERSION(backing_inode) ||
> +                   backing_inode->i_sb->s_dev !=3D iint->real_dev ||
> +                   backing_inode->i_ino !=3D iint->real_ino ||
> +                   !inode_eq_iversion(backing_inode, iint->version)) {
> +                       iint->flags &=3D ~IMA_DONE_MASK;
> +                       iint->measured_pcrs =3D 0;
> +               }
> +       }
> +
Does this mean I need to mount ext4 with `-o iversion`? Or has it been
enabled by default?

I can test this patch out sometime this week and verify it fixes the
performance regression.

Thanks!
