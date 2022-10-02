Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33E5F22E8
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Oct 2022 13:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiJBL2T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 Oct 2022 07:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBL2S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Oct 2022 07:28:18 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Oct 2022 04:28:15 PDT
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E919C2A731;
        Sun,  2 Oct 2022 04:28:15 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id C9EF1C02A0;
        Sun,  2 Oct 2022 13:10:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1664709029;
        bh=UhWwiZWSA+9PF4RhFQp6epUywS14Bc/N/EjEyRvAKsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WBxr9c3D0MlO7zTT+oxFUghLPHRJRJ8oc0U/GE5Jwb0C2Mz/+FTFJNld5Ucq67FQ+
         TodwBx3hYciOr0Sx1H6IPUmaPh/EV9v5XxDcI4g8rVrXNDg5/xFuN1NLhHw6Cpic6E
         PT389neq6GP5LlxWIr+pfiakE8sRbofIYc3L6ezOoWl1EryMK/rizcimwfaLiLUSq/
         pg9BHSmf+dxnP7JaU0cyyt/3WgSo5bo7bJrA+JFU6rQvQ1p8QVv3cJxZF++uiE1yH9
         aZ+CLIerpng3N8SCfqZDpdakm+M0cq6KtnuDMQoyt9EPCEn7rBUD8H35Xj6p4YrRVe
         trkUJw9Cx4pst2zc8Ski8Qqfp3VmanWFNKzyVv1Iv7hOLqAZby1WwFpWthy/NNd9Ox
         KznyRL7RldZJu7aO36bbuCqGc0+hkyvH4mjocwrxYussMBT2s5ql6ovSdQFkrixIaI
         HXpJNhNaisYu8i4NM0turgWzQPvF1k/TMaXvOzLtWsWIZ35dLGbXoXp0LoNOGZtVCW
         iHf82rguNFvWddr6zWzixsvA4adrnZQEeTljJYaOfA3+My378GAo7vpkI/xNiNh0/3
         BlRxvJtHY6hWrPDZjz4PbIDfvfi0sdtc3fGdYJVFJjb1HgCzvckG6qm9KjbcYvZbkX
         m/fJD8UHcEQMIKkxY2Qg8J+0=
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 7FE09C0272;
        Sun,  2 Oct 2022 13:10:29 +0200 (CEST)
Date:   Sun, 2 Oct 2022 13:10:14 +0200
From:   Morten Linderud <morten@linderud.pw>
To:     Erkki Eilonen <erkki@bearmetal.eu>
Cc:     jarkko@kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de
Subject: Re: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI
 address
Message-ID: <20221002111014.za35mf67yn53riji@framework>
References: <Yqooof3If/y9lBPC@iki.fi>
 <20221001215223.783896-1-erkki@bearmetal.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221001215223.783896-1-erkki@bearmetal.eu>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Oct 02, 2022 at 12:52:24AM +0300, Erkki Eilonen wrote:
> > If this is not something you can buy off-the-shelf, it
> > unfortunately does not cut.
> 
> For a N=2, we're having the same issue with a set of OTC machines.
> 
> Device: QuantaGrid D53X-1U
> BIOS:
>   Vendor: INSYDE Corp.
>   Version: 3A16.Q402
>   Release_Date: 11/10/2021
> 
> ACPI TPM2 table:
>   [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface table]
>   [004h 0004   4]                 Table Length : 0000004C
>   [008h 0008   1]                     Revision : 04
>   [009h 0009   1]                     Checksum : 8C
>   [00Ah 0010   6]                       Oem ID : "INSYDE"
>   [010h 0016   8]                 Oem Table ID : "WHITLEY "
>   [018h 0024   4]                 Oem Revision : 00000002
>   [01Ch 0028   4]              Asl Compiler ID : "INTL"
>   [020h 0032   4]        Asl Compiler Revision : 00040000
>   
>   [024h 0036   2]               Platform Class : 0001
>   [026h 0038   2]                     Reserved : 0000
>   [028h 0040   8]              Control Address : 0000000000000000
>   [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]
>   
>   [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
>   [040h 0064   4]           Minimum Log Length : 00010000
>   [044h 0068   8]                  Log Address : 0000000043274000
> 
> Fallback to the UEFI eventlog is what we did for a short term fix too. Will try to contact the vendor for a fixed ACPI table long term.
> 
> Morten: Did you get in contact with the vendor about this? Looks like a class error across different devices.


It was part of the Framework 3.06 BIOS firmware update which was released a year ago.

> Fix TPM Event log table resource pointer.

https://knowledgebase.frame.work/en_us/framework-laptop-bios-releases-S1dMQt6F

https://community.frame.work/t/known-issues-on-early-framework-laptops/4551/55

I have also seen evidence of this on Lenovo laptops from time to time, but they
seem to be fixed with firmware updates fairly quickly.

I'd still like this to see this fixed in the kernel.

-- 
Morten Linderud
PGP: 9C02FF419FECBE16
