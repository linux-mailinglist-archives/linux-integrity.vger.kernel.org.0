Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C957E4FC254
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Apr 2022 18:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbiDKQbN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Apr 2022 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiDKQbN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Apr 2022 12:31:13 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A9F2E
        for <linux-integrity@vger.kernel.org>; Mon, 11 Apr 2022 09:28:59 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 125so14608913pgc.11
        for <linux-integrity@vger.kernel.org>; Mon, 11 Apr 2022 09:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=HDYSTRRT3+AacCFfiu7p2hOk/dwoWLIB3+rk+R1q5/Fy8llvAViPlOLr+dHRHDtnqk
         r2JDxyWlPvKsLKr0lltsmzFIEBE0wF/R0OzvOyAbugPXVdFQ7nQzCqBUwiOQnAKcua8T
         Fjn3G3AYgxrX7Q1YSgiAKA1yfiNJrzACtRqQUot8xG/BHh0a33NL1kHJpLEzoSN8zR5B
         SC5XF/Wcja0E2If90Hr8ix9m6hRp82J3zixC59Z6d1HUd5IDXZ300YB/7ettlAblo+k9
         1acRJ5utlEAM/OTwYHTxp33c9fO9a/jmBj3+FqcbZN+L5n7QNy6F+QK8IptjQOSVnzVs
         n71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AUKkoVmkvHuUY6auh1d5fFUay2/FPDzwTJg+Zl9W0e1GOHnbMMhSTFWJrB0F8YPxXC
         ewcn49tOeV35HBQtr0rw5sn/34OgVxIrxxXffOuqb0/YkhIiwZWHcvtAfs0KphbBEnV1
         LFKleUdqamUBKlOGa/Jf6p4STKhE56bIgaDfxltsSpiEpcR5U0DiMluxL9XS4AYml2Pp
         GRHkWj7TNMGad6L/Eh3JL8oKHei4PopN8QH5r6fkqQ9ITFETdJdkEQ+LsHR4wZgkHiuo
         T0GaEeA+XL3OyYHVj9YM9xeCBGk7JBqE0yaz8VRdPT5FzkY+ybYSR2P/pK81VTPar3rZ
         7wYA==
X-Gm-Message-State: AOAM530Z4Pz3Y27MQ4w5M3pHJX0sxeFNIsxzqXRFgWkSvq4CNCiyJ79c
        2Nw32AG6xLE0FbnX/xWQT25ga62Ypxq902Zb5jA=
X-Google-Smtp-Source: ABdhPJxj3/QRdsMpcGXi0Hg7XpSHoZ/dIu/cUw67yoXbnxzn9OkMY0N1AVZKx82kUFp2/KfrtjU1NeiyKZHRh0OahCk=
X-Received: by 2002:a63:4a0d:0:b0:382:aad5:bbe8 with SMTP id
 x13-20020a634a0d000000b00382aad5bbe8mr26743235pga.535.1649694538613; Mon, 11
 Apr 2022 09:28:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:70d4:b0:7c:741a:e189 with HTTP; Mon, 11 Apr 2022
 09:28:58 -0700 (PDT)
Reply-To: robertsodjo63@gmail.com
From:   Roberts kodjo <robertazulioffice8@gmail.com>
Date:   Mon, 11 Apr 2022 16:28:58 +0000
Message-ID: <CAGDZC87k=R3fTDU3JhGW376GKCFZCRS4H3nH0tu36Bq+_zbpJw@mail.gmail.com>
Subject: =?UTF-8?B?16nXnNeV150sINee15Qg16nXnNeV157XmiDXlNeZ15XXnSDXnten15XXldeUINep15DXqg==?=
        =?UTF-8?B?INeR16HXk9eoINeR15HXqNeZ15DXldeqINeY15XXkdeULCDXp9eZ15HXnNeqINeQ16og15TXlNeV15M=?=
        =?UTF-8?B?16LXlCDXlNeQ15fXqNeV16DXlCDXqdec15k/?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


