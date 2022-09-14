Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9375B8F57
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 21:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiINTq6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINTq6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 15:46:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1E30F79;
        Wed, 14 Sep 2022 12:46:56 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EIEBvq023126;
        Wed, 14 Sep 2022 19:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xNiK3gZS3pLIKa9JSGntXOA2XCRU+i8Esq3R9aBNaxw=;
 b=RM/MLbXUac6dS9GkcfBkZX47qJRtjMyC/0aidBIDxrGAuwee7shy7iAeH7Pz5ZUzwgmB
 g6yA2jvCZbkb0LOPHkzmU9e8Rf3YPfFJk8hIJFDrxnvV9lGkcQ05hviHJ/0iWJbtkRtE
 v4rQ4VXlJbOFk8kysYgViDx7A/sU95t9/uXgjA1y2HrfVr3Ix3Ts/f6Tk3U3lWcX4v03
 9UX2h1Go2QNpnsxAomIjnczk93Z3+DQ9TxrHuzHsoDKD2WT+KeBsjaaQYA2KjkErwaIF
 xUc344NKbzIfiUBD1p3/tLMW9yGpcMV2UUWCreY4A8j1IbG1MoxURidZMG9tpyOtXUVK WA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkm252jg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 19:46:44 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EJZERg030370;
        Wed, 14 Sep 2022 19:46:43 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3jjy6jxqxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 19:46:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EJkg0J18219652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 19:46:42 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7B9328059;
        Wed, 14 Sep 2022 19:46:42 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71FB22805E;
        Wed, 14 Sep 2022 19:46:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 19:46:42 +0000 (GMT)
Message-ID: <f8c8b3dd-f77b-7917-6029-a288255fee8a@linux.ibm.com>
Date:   Wed, 14 Sep 2022 15:46:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <20220901214610.768645-1-stefanb@linux.ibm.com>
 <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
 <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IbgHdEuAjcsALyOVikbmHIyCbQAUIW99
X-Proofpoint-ORIG-GUID: IbgHdEuAjcsALyOVikbmHIyCbQAUIW99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_08,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=932 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140095
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/14/22 14:01, Rob Herring wrote:
> On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>
>>
>> Hi Rob,
>>
>>     can you take this series in your tree?
> 
> IMO, it should be someone that cares about TPM, kexec, or powerpc.
> Yes, there's code in drivers/of/, but that is purely to avoid
> duplication of code across powerpc and arm64.

What about 1/4? Can someone else take it into their tree?

    Stefan
> 
> Rob
