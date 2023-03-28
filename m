Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA376CB50B
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Mar 2023 05:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjC1Dq2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Mar 2023 23:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjC1Dq1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Mar 2023 23:46:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551CB119;
        Mon, 27 Mar 2023 20:46:26 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PlwZX0p0bzKpjv;
        Tue, 28 Mar 2023 11:45:56 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 11:46:23 +0800
Message-ID: <6f3c30a9-9133-65a8-ee30-81ec8c053777@huawei.com>
Date:   Tue, 28 Mar 2023 11:46:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
To:     <romanosauce57@gmail.com>
CC:     <dmitry.kasatkin@gmail.com>, <guozihua@huawei.com>,
        <jmorris@namei.org>, <khoroshilov@ispras.ru>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <lvc-project@linuxtesting.org>, <paul@paul-moore.com>,
        <roberto.sassu@huawei.com>, <serge@hallyn.com>,
        <zohar@linux.ibm.com>
References: <20230314180308.17909-1-romanosauce57@gmail.com>
Subject: Re: [PATCH] ima: Fix potential NULL pointer access in
 ima_match_rules()
Content-Language: en-US
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <20230314180308.17909-1-romanosauce57@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tested-by: GUO Zihua <guozihua@huawei.com>

-- 
Best
GUO Zihua
