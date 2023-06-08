Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF672834A
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Jun 2023 17:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbjFHPLR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Jun 2023 11:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjFHPLQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Jun 2023 11:11:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7F2D63;
        Thu,  8 Jun 2023 08:11:14 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358EqCxh003113;
        Thu, 8 Jun 2023 15:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LUPON5A/yOq6SV0ahS6sBgfeIZzY9Jqq451H2rYMksg=;
 b=GfhCC1litHF3NBsn7H5W8uW5ERTdCZjzUz45Iw2nzr2sbVP8rJ++PD3lg+xsRY/qNx57
 12vEmKGYDQjehtKUvDo8KEQAvEb8CsuJeyU4pdIsTm42cgtj5MpyjqIo0Mo9X75l3F+h
 BnbDiMiroF1JxEIcDtwtXUTNP4SigsdEC6aHzb+AtfZuSc0ClFP1Ud1IFjovVB1pqNYR
 MaKP4z2oy9UPoTSBobY4zrEMLlwx+eTlXX2LpTWzEypDvR0bqQr1moH4B38GPqqXgSI7
 YQIthQqjMmo9t8pCvFe9rSVzx1sGFNVuuR2QnOrv8w+Y7aIa+g7YBnONvPCzNBHqRN4/ ng== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3h4p8hqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 15:11:03 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 358Cnfc6000311;
        Thu, 8 Jun 2023 15:11:01 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3r2a76s9jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 15:11:01 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 358FB0DC61210898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 15:11:01 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F8FC58066;
        Thu,  8 Jun 2023 15:11:00 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBAE958053;
        Thu,  8 Jun 2023 15:10:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jun 2023 15:10:59 +0000 (GMT)
Message-ID: <666b8422-3e4f-3d88-1ff7-1f650dd401ce@linux.ibm.com>
Date:   Thu, 8 Jun 2023 11:10:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tpm: factor out the user space mm from
 tpm_vtpm_set_locality()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20230530205001.1302975-1-jarkko@kernel.org>
 <8f15feb5-7c6e-5a16-d9b4-008b7b45b01a@linux.ibm.com>
 <324df0fa5ad1f0508c5f62c25dd1f8d297d78813.camel@kernel.org>
 <0438f5e3-ca42-343b-e79e-5f7976ec8a62@linux.ibm.com>
 <CT7AOKF4OGHA.2S5VUEAG76GYB@suppilovahvero>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CT7AOKF4OGHA.2S5VUEAG76GYB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mR7sOTxaBrTwFfyiL_U6TBxePEWg73Om
X-Proofpoint-ORIG-GUID: mR7sOTxaBrTwFfyiL_U6TBxePEWg73Om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_10,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306080131
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/8/23 09:14, Jarkko Sakkinen wrote:
> On Wed May 31, 2023 at 8:01 PM EEST, Stefan Berger wrote:
>>
>>
>
>>
>> This is swtpm picking up this command with its user buffer.
>>
>>     So, I am not sure at this point what is wrong.
>>
>>      Stefan
> 
> The answer was below but in short it is that you have a function that
> expects __user * and you don't pass user tagged memory.

There are two functions that expect user tagged memory:

static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
				    size_t count, loff_t *off)
static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
				     size_t count, loff_t *off)

the correspond to this interface:

struct file_operations {
	struct module *owner;
	loff_t (*llseek) (struct file *, loff_t, int);
	ssize_t (*read) (struct file *, char __user *, size_t, loff_t *);
	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);

defined here:

static const struct file_operations vtpm_proxy_fops = {
	.owner = THIS_MODULE,
	.llseek = no_llseek,
	.read = vtpm_proxy_fops_read,
	.write = vtpm_proxy_fops_write,

Conversely, I see no other function interfaces in tpm_vtpm_proxy.c where the code would be missing the __user.

Neither do I see any functions where I am passing a __user tagged buffer as parameter that shouldn't have
such a tag on it or the reverse where a plain buffer is passed and it should be a __user tagged buffer.

    Stefan

> 
> Even tho it is a bug, I think cc to stable is not necessary given that
> it is not known to blow up anything. The main problem is that we have
> code that does not work according to the expectations.
> 
> BR, Jarkko
> 
> 
