Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5A5221BA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 18:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343987AbiEJQzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347685AbiEJQzT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 12:55:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E484162118;
        Tue, 10 May 2022 09:51:20 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AFJjbp026754;
        Tue, 10 May 2022 16:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MtEUdrFg5vVjbNQCS/BU2XYQmsKHTDxuTJJMpHB118M=;
 b=eT/g0iwRdTnHQeQijJOg2K/U6rbI2tmCnru3jZ1b2HoQR077MWSjm296OHocij0et23e
 w7HT+xEliTu60ZSC95uUdfT2n85pQunzIzI2SkmIFNzwJSPf076wXcG0MKsl5HKPAg86
 GbaVpX7+143ggcNMLo/j2RX2JLLf4gMUzxUN7yLBN5a3MZzRg+JkMvfhUMPKILXnLpBW
 V7egPydqAQwrq6RkmyLgqQrRyqBgQxVz8RJJB8YjhZlVno9CCmBfaAj9VgUCeKhq5ZBY
 6yxW1bDrBBWmthmIqnm+8Cx5l8DWjzcK1qDAlC8blLG9PLcUahToPsNnbgng4ZMptObt 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fytkkt5sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 16:50:44 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24AGTFMC001381;
        Tue, 10 May 2022 16:50:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fytkkt5sc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 16:50:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AGT47v027915;
        Tue, 10 May 2022 16:50:42 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3fwgd96b1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 16:50:42 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AGof3f61342026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 16:50:41 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67F9E124055;
        Tue, 10 May 2022 16:50:41 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 033AD124058;
        Tue, 10 May 2022 16:50:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 16:50:40 +0000 (GMT)
Message-ID: <c76f52d9-07eb-39dd-dad4-43b108696539@linux.ibm.com>
Date:   Tue, 10 May 2022 12:50:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-2-stefanb@linux.ibm.com>
 <20220509195414.GA30894@mail.hallyn.com>
 <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rm2ZvGlia5ghHqQtREAD3mTlCv2558Ga
X-Proofpoint-GUID: FwZzpy1yN5E-3p3du-KT6wkIbBSpD0C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_04,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=803 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205100072
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/10/22 06:25, Christian Brauner wrote:
> On Mon, May 09, 2022 at 02:54:14PM -0500, Serge Hallyn wrote:
>> On Wed, Apr 20, 2022 at 10:06:08AM -0400, Stefan Berger wrote:
>>> From: Christian Brauner <brauner@kernel.org>
>>>
>>> When securityfs creates a new file or directory via
>>> securityfs_create_dentry() it will take an additional reference on the
>>> newly created dentry after it has attached the new inode to the new
>>> dentry and added it to the hashqueues.
>>> If we contrast this with debugfs which has the same underlying logic as
>>> securityfs. It uses a similar pairing as securityfs. Where securityfs
>>> has the securityfs_create_dentry() and securityfs_remove() pairing,
>>> debugfs has the __debugfs_create_file() and debugfs_remove() pairing.
>>>
>>> In contrast to securityfs, debugfs doesn't take an additional reference
>>> on the newly created dentry in __debugfs_create_file() which would need
>>> to be put in debugfs_remove().
>>>
>>> The additional dget() isn't a problem per se. In the current
>>> implementation of securityfs each created dentry pins the filesystem via
>>
>> Is 'via' an extra word here or is there a missing word?
>>
>> I'll delay the rest of my response as the missing word may answer my
>> remaining question :)
> 
> It can be both. It should either be removed or it should be followed by
> "securityfs_create_dentry()". securityfs_create_dentry() takes two

I am adding "securityfs_create_dentry()" to the text.
