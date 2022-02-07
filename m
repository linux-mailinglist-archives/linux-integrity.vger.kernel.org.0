Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D424AC8D8
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 19:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiBGSr4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 13:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiBGSpT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 13:45:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75603C0401DA;
        Mon,  7 Feb 2022 10:45:18 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217Iihkg030588;
        Mon, 7 Feb 2022 18:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JWobRtZJdiu1UFWJsYFo6dTuwFzOvnol71RgZ3pYM7g=;
 b=gpE1Y5Zgrvtptli5BejmreD4vbWsxRhPyMSS8pHDCf6OyjaA/CkrTjHY7vvhOrNRY2xl
 tkfvzQ9c+Bf7OaAo2iyppSFRkxb92F88ydGLqQ/Kkq7kZUOCZ5oR84x8cRf7mi9ep9gl
 d0ogishXHp2mwSfHVjybBR4frK4176pkgXIopjpGxNNsS2m+P6+LeV54QOsGnhwFiWT0
 j4FcHjPTHVM1cjXu/raSjaLHjg9H6YhyqUjqfh+cNVg/YbF6+Ts6RWUNva1ILG41aYGS
 orgd3sk8vm0EviCeLDXap5Z9i3P2X1rpWVHnOztR7ITMh9VeEbGlsqolej1oOi55sgW0 Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22whh05p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 18:44:48 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217IikRK030861;
        Mon, 7 Feb 2022 18:44:48 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e22whgyuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 18:44:48 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217IXcXe016001;
        Mon, 7 Feb 2022 18:43:33 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3e1gvabkkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 18:43:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217IhWXr34013446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 18:43:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E96BCB206B;
        Mon,  7 Feb 2022 18:43:31 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87758B2068;
        Mon,  7 Feb 2022 18:43:31 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 18:43:31 +0000 (GMT)
Message-ID: <cb94bd18-2d6c-772f-b16e-a4778480258b@linux.ibm.com>
Date:   Mon, 7 Feb 2022 13:43:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 12/27] ima: Define mac_admin_ns_capable() as a wrapper
 for ns_capable()
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Denis Semakin <denis.semakin@huawei.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-13-stefanb@linux.ibm.com>
 <20220205055826.GA15072@mail.hallyn.com>
 <9c8a09d6-6373-c8c2-c8ff-2b4c3f92ddf1@linux.ibm.com>
In-Reply-To: <9c8a09d6-6373-c8c2-c8ff-2b4c3f92ddf1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tcu-5Coy4UkbaOUi6lumKcgXTITFJmeT
X-Proofpoint-ORIG-GUID: iFPtb5sqsV7f3jo0ECd3tQdAx54PcLLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/6/22 12:20, Stefan Berger wrote:
>
> On 2/5/22 00:58, Serge E. Hallyn wrote:
>> On Tue, Feb 01, 2022 at 03:37:20PM -0500, Stefan Berger wrote:
>>> Define mac_admin_ns_capable() as a wrapper for the combined 
>>> ns_capable()
>>> checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
>>> true on the check if either capability or both are available.
>>>
>>> Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will 
>>> allow
>>> an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
>>> less privileges than CAP_SYS_ADMIN.
>>>
>>> Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   include/linux/capability.h      | 6 ++++++
>>>   security/integrity/ima/ima.h    | 6 ++++++
>>>   security/integrity/ima/ima_fs.c | 5 ++++-
>>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/capability.h b/include/linux/capability.h
>>> index 65efb74c3585..991579178f32 100644
>>> --- a/include/linux/capability.h
>>> +++ b/include/linux/capability.h
>>> @@ -270,6 +270,12 @@ static inline bool 
>>> checkpoint_restore_ns_capable(struct user_namespace *ns)
>>>           ns_capable(ns, CAP_SYS_ADMIN);
>>>   }
>>>   +static inline bool mac_admin_ns_capable(struct user_namespace *ns)
>>> +{
>>> +    return ns_capable(ns, CAP_MAC_ADMIN) ||
>>> +        ns_capable(ns, CAP_SYS_ADMIN);
>> Do you care about audit warnings?  If the task has CAP_SYS_ADMIN but
>> not CAP_MAC_ADMIN, is it desirable that selinux_capable() will audit the
>> CAP_MAC_ADMIN failure?
>
> Good point.  I will switch both to ns_capable_noaudit() so that the 
> user cannot provoke unnecessary audit message.

Actually,  I will only change the MAC_ADMIN to not do auditing and not 
change the auditing behavior related to SYS_ADMIN.

    Stefan


