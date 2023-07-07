Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AA74B15C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGGNAl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGNAk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 09:00:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E8170C
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 06:00:39 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Cu8ni024664;
        Fri, 7 Jul 2023 13:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/RfW+H6HuSHaoDRhZa7QQy1R3krdvUDNGZk8+CKwmwk=;
 b=FmTsyFTAy5Vr/tDBmQgITUde4SBJ1AgHeU9Qp8rqO0W+lAOy6nyKeQf9Tw+GK+rkZ6mg
 eoGTktGCUISb+/OOK9Zj8CzCyO4MwZeeUnja6Wco/WIyJuiex9BulD98ZLmYrP1FH6C+
 /npYasD18Qm2Nk7nx8laEuRv0bij+Pl/7H9Jhlj5pj9llzmbb7Z9KEE99I6DzXEI4dK7
 s2lPEAwJUMawQO2jHX/S0kHu4OMKaFZe+9gfgI1aawDUfpC9f/sv4huyPbL12HzY2F/V
 xwlSdSFtLdpgoiocRaN6qC1CYLEx/VED9/GeZnXsu83MMhh5oAQfoEJfqryvQX0rSbqL /Q== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpk59830f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:00:15 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367AOxRr017839;
        Fri, 7 Jul 2023 13:00:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3rjbs65gnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:00:14 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367D0DBj42664212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 13:00:13 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BFE358063;
        Fri,  7 Jul 2023 13:00:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CF015805F;
        Fri,  7 Jul 2023 13:00:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 13:00:12 +0000 (GMT)
Message-ID: <494dffc6cc7cfb8c6ca78f3bae442d57362a8857.camel@linux.ibm.com>
Subject: Re: [PATCH 01/10] ima: implement function to allocate buffer at
 kexec load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 07 Jul 2023 09:00:11 -0400
In-Reply-To: <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-2-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VtN6U0vQllDOic3NboU5CP0_imEZVr3t
X-Proofpoint-ORIG-GUID: VtN6U0vQllDOic3NboU5CP0_imEZVr3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_08,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=858 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> IMA does not provide a mechanism to allocate memory for IMA log storage
> during kexec operation.

The IMA measurement list is currently being carried across kexec, so
obviously a buffer is being allocated for it.  IMA not allocating
memory for the measurment list is not the problem statement.  Please
concisely provide the problem statement, explaining why IMA needs to
allocate the buffer.

> The function should handle the scenario where
> the kexec load is called multiple times.

Currently the buffer is being freed with the kexec 'unload'.  With this
patch IMA is allocating a buffer for the measurement list, which needs
to be freed independently of the kexec 'unload'.

> Implement a function to allocate buffer of size kexec_segment_size at
> kexec load.  If the buffer was already allocated, free that buffer and
> reallocate.  Finally, initialihze ima_khdr struct. 
> 
> The patch operates under the assumption that the segment size does not
> change between kexec load and execute.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

-- 
thanks,

Mimib




