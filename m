Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540166092E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 17:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfGEPVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 11:21:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbfGEPVe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 11:21:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65FHEwU139689;
        Fri, 5 Jul 2019 11:20:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tj80kaywk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 11:20:58 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x65FKvOt003765;
        Fri, 5 Jul 2019 11:20:57 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tj80kayw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 11:20:57 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x65FEcfC024677;
        Fri, 5 Jul 2019 15:20:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 2tdym7mvjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 15:20:56 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x65FKtnE52625730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jul 2019 15:20:55 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7AD124053;
        Fri,  5 Jul 2019 15:20:55 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BB1F124052;
        Fri,  5 Jul 2019 15:20:54 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.85.133.199])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jul 2019 15:20:53 +0000 (GMT)
Subject: Re: [PATCH] Revert "tpm: pass an array of tpm_extend_digest
 structures to tpm_pcr_extend()"
To:     Tyler Hicks <tyhicks@canonical.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org
References: <20190701131505.17759-1-msuchanek@suse.de>
 <8e4cc105b748c5395132b4d3d29d0d9b30a8720c.camel@linux.intel.com>
 <cf2ea579-41c2-42da-2df3-0b1f12e1c639@huawei.com>
 <1562240882.6165.78.camel@linux.ibm.com>
 <1562255201.6165.143.camel@linux.ibm.com> <20190704195857.GB6105@elm>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <abcc3748-8471-8965-046e-9d9431b4f0e9@linux.vnet.ibm.com>
Date:   Fri, 5 Jul 2019 11:20:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190704195857.GB6105@elm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050186
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tyler,


On 07/04/2019 03:58 PM, Tyler Hicks wrote:
> Hey Mimi!
>
> On 2019-07-04 11:46:41, Mimi Zohar wrote:
>> Hi Jarkko,
>>
>> On Thu, 2019-07-04 at 07:48 -0400, Mimi Zohar wrote:
>>> On Thu, 2019-07-04 at 13:28 +0200, Roberto Sassu wrote:
>>>> On 7/4/2019 12:03 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, 2019-07-01 at 15:15 +0200, Michal Suchanek wrote:
>>>>>> This reverts commit 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400 to avoid
>>>>>> following crash:
>>>>> Thank you. I think this the right choice for the moment. I fixed
>>>>> a trivial checkpatch.pl error and added the mandatory tags. Can
>>>>> you check quickly v2 (just posted)?
>>>>>
>>>>> I already made it available in my master and next.
>>>> Could you please wait few days? I would prefer to fix this issue instead
>>>> of reverting the whole patch.
>>> Nayna posted a patch late yesterday titled "tpm: fixes uninitialized
>>> allocated banks for IBM vtpm driver", which addresses this bug.
>> Now with my review, and with Sachin Sant's and Michal Suchánek
>> testing, instead of reverting this patch could you pick up Nayna's
>> patch instead?
> It looks to me like the revert would also fix a bug that is keeping the
> eCryptfs module from loading when the TPM is in an "inactive" state:
>
>    https://bugzilla.kernel.org/show_bug.cgi?id=203953
>
> I just noticed that it was recently discussed here, too:
>
>    https://lore.kernel.org/linux-integrity/1562244125.6165.95.camel@linux.ibm.com/T/#t
>
> I believe that the revert would fix it because the call to
> init_digests()/tpm_get_random() would no longer be in the path of
> loading ecryptfs.ko (which depends on encrypted-keys.ko, which depends
> on trusted.ko).
>
> If the revert isn't used, we'll need a different fix for bug 203953. It
> should be an easy fix but I don't want it to be forgotten.


I think if TPM is inactive/disabled, it needs to be handled during 
tpm_chip_register() itself. However, probably that needs more analysis 
and discussion. For now, in context of the trusted.ko module, it seems 
init_trusted() should "put_device", but continue even if init_digests() 
fails, that will fix the issue.


Thanks & Regards,
         - Nayna
