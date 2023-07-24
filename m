Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273B775EEC3
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jul 2023 11:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjGXJMc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jul 2023 05:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXJMb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jul 2023 05:12:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4812A;
        Mon, 24 Jul 2023 02:12:28 -0700 (PDT)
Received: from kwepemm600006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8Z9q1MFGzHqhN;
        Mon, 24 Jul 2023 17:09:51 +0800 (CST)
Received: from [10.174.177.30] (10.174.177.30) by
 kwepemm600006.china.huawei.com (7.193.23.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 17:12:23 +0800
Message-ID: <92e2a8ca-cd3f-7db5-c0cf-03a72695524d@huawei.com>
Date:   Mon, 24 Jul 2023 17:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] kexec_lock:Fix comment for kexec_lock
To:     Baoquan He <bhe@redhat.com>
CC:     <kexec@lists.infradead.org>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>, <ebiederm@xmission.com>,
        <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
References: <26ff12fe-347b-d908-0327-73cf3c83b00b@huawei.com>
 <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
From:   "Wenyu Liu(D)" <liuwenyu7@huawei.com>
In-Reply-To: <ZL405LGPVa6lOl5s@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.30]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600006.china.huawei.com (7.193.23.105)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks for the tips, I will post a new one later

在 2023/7/24 16:23, Baoquan He 写道:
> On 07/24/23 at 11:45am, Wenyu Liu(D) wrote:
>> kexec_mutex is replaced by an atomic variable in
>> 56314b90fd43bd2444 (panic, kexec: make __crash_kexec() NMI safe).
> 
> You could use a distros kernel or customized kernel and made change
> based on that. The commit id isn't correct. I pasted the right one
> at below.
> 
> commit 05c6257433b ("panic, kexec: make __crash_kexec() NMI safe")
> 
> Other than this, this looks good. You can post a new one with my ack.
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>>
>> Fix some comment that still using kexec_mutex.
>>
>> Signed-off-by: Wenyu Liu  <liuwenyu7@huawei.com>
>> ---
>>  kernel/kexec_file.c                | 2 +-
>>  security/integrity/ima/ima_kexec.c | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 881ba0d1714c..b5bbb2fe0668 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -624,7 +624,7 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>   * kexec_add_buffer - place a buffer in a kexec segment
>>   * @kbuf:  Buffer contents and memory parameters.
>>   *
>> - * This function assumes that kexec_mutex is held.
>> + * This function assumes that kexec_lock is held.
>>   * On successful return, @kbuf->mem will have the physical address of
>>   * the buffer in memory.
>>   *
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 419dc405c831..ad133fe120db 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -77,7 +77,7 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>>   * Called during kexec_file_load so that IMA can add a segment to the kexec
>>   * image for the measurement list for the next kernel.
>>   *
>> - * This function assumes that kexec_mutex is held.
>> + * This function assumes that kexec_lock is held.
>>   */
>>  void ima_add_kexec_buffer(struct kimage *image)
>>  {
>> --
>> 2.33.0
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 
