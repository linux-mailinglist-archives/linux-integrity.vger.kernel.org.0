Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415E751C1C5
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379283AbiEEOD0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 10:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEOD0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 10:03:26 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136D83617E
        for <linux-integrity@vger.kernel.org>; Thu,  5 May 2022 06:59:47 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u205so4263340vsu.6
        for <linux-integrity@vger.kernel.org>; Thu, 05 May 2022 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ikvLHKPwXc8SwXWbFJlAucH7yXhIQw1zrapwwT0e9zA=;
        b=LuT3usaImWLUBwWvQaa1Kjppb7vUfaUJU7ecYRxqS4QPx25M1BLeZISMSd4ZqSqhVc
         Rl8spSncilw7HnreJCa214uuptjCi+H6qJd3mqH5z5qQfYucOdayGFm1YYUp3IKB4rd+
         +BjxtONoe+cu7fhIoeytGi3BP6LNUuZuocfRn0N1nEB7JMnO7Cjk0tWB280uOFVjY82h
         1ZDaGezYKWWpBB/t7D7qpaNPgmdJIZVdKp1nZkKW0mfPi7UB693aOjqmwidFBLDqsoZp
         y3mwHeUN97QC38iD/6KOlFKWXy3pSS4IgaVh+pN33ZcdlWyce88PmAca5oC1jD6wOKym
         HznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ikvLHKPwXc8SwXWbFJlAucH7yXhIQw1zrapwwT0e9zA=;
        b=k4Xpt39uBALKpw3jR2siiR8TozsQo4xKGH3cqPZkoPV7oxnFuMhcBwwe350412obJa
         5Q2QANSiice5jGdQ4rVcIEMPGsyVHYHFNHgwsbEaOBCLt4HiqR890d/IpmQQvo7FsFsd
         AGkztNMkYMI7lM6EtElx3Ft552KvlDbfXoDXN1amn4RiUr8KNKW4nLmXIBB6bKu5Z0tI
         tmd5i4mNPABUmkhihUupd4mw/6KBWaESFtjVE/pq4Hhl0VEI6c5d3fAYGgE8hoFm5VFo
         GxN+3y7OsVRIKsCsTigrAYWVue1IQZnZ2cV4Bb7qa5/SIM+W7vXEkYrsjex7lxwzR+0C
         K0OA==
X-Gm-Message-State: AOAM531B1ES8zmjWtAuvea1CaN0mpTRnylpi6iSyZGxgfd0ezULhog0L
        JJwZxp380O+HvkweoL2Wp6dOaEXuBoecJNaRUqZSPTU+wV8=
X-Google-Smtp-Source: ABdhPJxSkbV0e4ZjKySraY3GvdbcX91c4lx6RcvRku5kuaBjbUZMhYLKtqWFcXV0U9jMW2hKCv367l+LEI4QeWqrsd8=
X-Received: by 2002:a67:ea90:0:b0:32c:d17d:7c25 with SMTP id
 f16-20020a67ea90000000b0032cd17d7c25mr7669480vso.54.1651759186008; Thu, 05
 May 2022 06:59:46 -0700 (PDT)
MIME-Version: 1.0
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 5 May 2022 08:59:35 -0500
Message-ID: <CAFftDdrGYV=VwNPjypoOs1SmpNeZMTfrAFhht=zVOgC0hDrHSA@mail.gmail.com>
Subject: Question on permissions of runtime and bios measurements files
To:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently the tss command line tools can't access the system
measurement logs for users even if they are in the group tss:

crw-rw---- 1 tss root 10, 224 Mai  3 17:22 /dev/tpm0
-r--r----- 1 root root 0 Mai  3 17:22
/sys/kernel/security/ima/binary_runtime_measurements
-r--r----- 1 root root 0 Mai  3 17:22
/sys/kernel/security/tpm0/binary_bios_measurements

So with tss2_quote, a quote can be computed but not the pcrLog for the
system PCRs.
The problem could be solved if the log files would be owned by tss.
But that could create privacy issues because the pcrLog would e.g.
contain executables in user home directories.
Do you have any suggestions how the problem could be addressed?

Thanks,
Bill
