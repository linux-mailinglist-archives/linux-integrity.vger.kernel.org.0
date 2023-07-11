Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970EA74F99A
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jul 2023 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGKVMO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jul 2023 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGKVMM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jul 2023 17:12:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CE5133
        for <linux-integrity@vger.kernel.org>; Tue, 11 Jul 2023 14:12:11 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BL9jW1002442;
        Tue, 11 Jul 2023 21:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/jbmUM/Tz5PwYQ7xibcV54GFdtSsVEw7ymNllB0dx7E=;
 b=sNxzswunyHLLzZnCfQZdMcKPULi7FTMBca+QNXlM+j9G7dL/udJSddAvioNRPMlslYXU
 sjb9K8fwYmhCffM03mXg7QPxxdD+E+2xdgJjdEoKAccUbLZwUWV0w2JI17hZxZIo+Ujr
 Lj0EJhR6DKalQKZALXq/xEjnVH4OyDQV0whw9kz6qtmuQ5Za9QGI02u6bUYodrrwvuMt
 fVLB9cTT+yUPVzAVnCpASGAHTEwb49Xrf6uxWYB93fdi3tMIGHj+BT+8/nLj8kRvdp2t
 Ywv0RnKaMSl8YecZolTRdq/y/VewWk0sx/KuZpiBwvsq/uCQA5SG1UPKlBdx49YnJzMS Ow== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rseg8gaak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 21:11:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36BEGJs7011647;
        Tue, 11 Jul 2023 21:11:51 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mgjbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 21:11:51 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36BLBosr34734376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 21:11:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52D9258058;
        Tue, 11 Jul 2023 21:11:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B5F58057;
        Tue, 11 Jul 2023 21:11:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.19.33])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jul 2023 21:11:49 +0000 (GMT)
Message-ID: <66ca5d5504291161d887d141bc43ce2a4c14ff8c.camel@linux.ibm.com>
Subject: Re: [PATCH 01/10] ima: implement function to allocate buffer at
 kexec load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
Date:   Tue, 11 Jul 2023 17:11:47 -0400
In-Reply-To: <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
         <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
         <31eb2a9c-7410-b655-43d2-3b2966d2d3da@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ajjQURlfE6K12wP7zNJ6D7w-6WsYI88s
X-Proofpoint-ORIG-GUID: ajjQURlfE6K12wP7zNJ6D7w-6WsYI88s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 mlxlogscore=967 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307110191
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-07-11 at 10:59 -0700, Tushar Sugandhi wrote:
> Adding Eric to cc.
> 
> On 7/7/23 06:00, Mimi Zohar wrote:
> > Hi Tushar,
> >
> > On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> >> IMA does not provide a mechanism to allocate memory for IMA log storage
> >> during kexec operation.
> > The IMA measurement list is currently being carried across kexec, so
> > obviously a buffer is being allocated for it.  IMA not allocating
> > memory for the measurment list is not the problem statement.  Please
> > concisely provide the problem statement, explaining why IMA needs to
> > allocate the buffer.
> >
> I meant IMA does not provide separate functions to allocate buffer and
> populate measurements.  Both operations are wrapped in an atomic
> ima_dump_measurement_list().

Ok.

> As I mentioned in the comment in the cover letter, if there is no such
> technical limitation to allocate the buffer and copy the measurements at
> kexec ‘execute’ – I will make the necessary code changes and update the
> above line in the patch description accordingly.

The "normal" way of making this type of change would be to split the
existing ima_dump_measurement_list() function.  Copying the measurement
list would still be named ima_dump_measurement_list().  The other could
be named ima_alloc_kexec_buf().  Both functions initially would be
called.

Eric, besides updating the buffer at kexec execute, is there anything
else that needs to be done (e.g. updating digests)?

> >> The function should handle the scenario where
> >> the kexec load is called multiple times.
> > Currently the buffer is being freed with the kexec 'unload'.  With this
> > patch IMA is allocating a buffer for the measurement list, which needs
> > to be freed independently of the kexec 'unload'.

> If we end up allocating the buffer at kexec ‘execute’ (which results in
> soft boot to next Kernel) – is it technically possible that
> kexec ‘unload’ being called after calling kexec ‘execute’?

> If not, should I still free the buffer at kexec ‘unload’ in this
> scenario?

The question is how to access the buffer once kexec_add_buffer() is
called.

Mimi

