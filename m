Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA6572A9AC
	for <lists+linux-integrity@lfdr.de>; Sat, 10 Jun 2023 09:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjFJHC0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 10 Jun 2023 03:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjFJHCW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 10 Jun 2023 03:02:22 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665A93A9B;
        Sat, 10 Jun 2023 00:02:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QdTBt3y1Sz9y5Yv;
        Sat, 10 Jun 2023 14:51:50 +0800 (CST)
Received: from [10.81.219.229] (unknown [10.81.219.229])
        by APP1 (Coremail) with SMTP id LxC2BwDnSubSH4RkcgIoAw--.4557S2;
        Sat, 10 Jun 2023 08:01:51 +0100 (CET)
Message-ID: <34b72280-ab31-15a1-f37e-58eac34a0d37@huaweicloud.com>
Date:   Sat, 10 Jun 2023 09:01:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 2/4] smack: Set the SMACK64TRANSMUTE xattr in
 smack_inode_init_security()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mengchi Cheng <mengcc@amazon.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        kamatam@amazon.com, yoonjaeh@amazon.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        bpf@vger.kernel.org, kpsingh@kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230603191518.1397490-1-roberto.sassu@huaweicloud.com>
 <20230603191518.1397490-3-roberto.sassu@huaweicloud.com>
 <9f4b7bef5d090da9de50ed1aa1e103abc19b125f.camel@huaweicloud.com>
 <CT7XVY50ISCC.1I60H7POH94ES@suppilovahvero>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <CT7XVY50ISCC.1I60H7POH94ES@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDnSubSH4RkcgIoAw--.4557S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyUtrW5XrWfJF15KF4kWFg_yoWxAFX_Zr
        40kwn3trZxXrs7urWv9Fy5Was2ga10kr1Yv3yUZ3W3C3Z5JayxWF4Yka4rZF95W3Z2ka9r
        K3ZYqFyYy347KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
        AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
        j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
        kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI
        1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
        XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        UWwZcUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj45+OQAAs5
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,PDS_RDNS_DYNAMIC_FP,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/9/2023 9:26 AM, Jarkko Sakkinen wrote:
> On Mon Jun 5, 2023 at 11:38 AM EEST, Roberto Sassu wrote:
>> On Sat, 2023-06-03 at 21:15 +0200, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> With the newly added ability of LSMs to supply multiple xattrs, set
>>> SMACK64TRASMUTE in smack_inode_init_security(), instead of d_instantiate().
> 
> nit: TRANSMUTE
> 
> Sorry, just hit into my eye. I skimmed it because I implemented original
> feature :-)

Cool!

Currently the transmute xattr is defined as:

#define XATTR_SMACK_TRANSMUTE "SMACK64TRANSMUTE"

so, should be good to say the full xattr name, right?

Thanks

Roberto

