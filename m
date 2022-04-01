Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561934EE8C3
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Apr 2022 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiDAHG5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Apr 2022 03:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343694AbiDAHGz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8551FCA0C1
        for <linux-integrity@vger.kernel.org>; Fri,  1 Apr 2022 00:05:06 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KVB2T0gxCzgYKH;
        Fri,  1 Apr 2022 15:02:57 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:37 +0800
Message-ID: <8609c0dc-1180-f410-e9cf-8f3ceee4c4cc@huawei.com>
Date:   Fri, 1 Apr 2022 15:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     <tianjia.zhang@linux.alibaba.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
Subject: Progress about SM2-with-SM3 signature support for PKCS #7.
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

Thank you for the all the work surrounding SM crypto algorithm and 
certificates.

I noticed that the patch implementing the support for SM2-with-SM3 
signature parsing in PKCS #7 has not been merged yet. Would you mind me 
asking about the progress of that patch?

-- 
Thanks!
GUO Zihua
