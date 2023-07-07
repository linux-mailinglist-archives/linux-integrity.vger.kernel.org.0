Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628874B243
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGGNz1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 09:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjGGNz0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 09:55:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE7C1FE8
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 06:55:25 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Dm68U018877;
        Fri, 7 Jul 2023 13:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9c8hJ+WnO77/JEIU9liATW2P9VnCg0TPVgGQquKgKz4=;
 b=AIA7OtCGrUFn0G2OwWbZ1mM6TZPaZKprc7K+Ie/IA70lRMpVJzvw9zhQIKUsjCgNgbxQ
 7ceo/XlJGLfEdPokQOSHn/vpGmTRsFyucQ9lSwT7ArFtuuPKApTVbpgs05lstAZAq+Yf
 DIlK+VlaQ0wsEAeAdPufPzFjtH6h1VtFylhriIOMC9W9hItyKK5lV0J2ZMJhEeUnBXus
 r75u8cIog702RO6XMSl4TwMpqcl4swNDTaN0S0zcHRLewwzvaxcqDjI/mMa6uYvNu9VQ
 C//TzdAD0LfjPqwthjiahStLHkQGHwmm2V6AV6iNWKQ5joAzTwRuScrquUYN+JBqm9f2 Zg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpkwgg488-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:55:10 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367CsSYP030154;
        Fri, 7 Jul 2023 13:55:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rjbs6e040-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:55:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367Dt8Ww8979002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 13:55:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A37C15805C;
        Fri,  7 Jul 2023 13:55:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4FF458059;
        Fri,  7 Jul 2023 13:55:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 13:55:07 +0000 (GMT)
Message-ID: <3a67093401f6d14224e9cef748a9e2c191d21fa1.camel@linux.ibm.com>
Subject: Re: [PATCH 07/10] ima: remove function ima_dump_measurement_list
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 07 Jul 2023 09:55:07 -0400
In-Reply-To: <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NOWmxTlesjIgP5JF0D9elMGEgYEwxwU6
X-Proofpoint-GUID: NOWmxTlesjIgP5JF0D9elMGEgYEwxwU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 mlxlogscore=524 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070125
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
> The ima_dump_measurement_list function was designed to iterate over the
> IMA measurement list and store each entry into a buffer.  The buffer,
> along with its size, would be returned to the caller.  However, the
> function is no longer required in the IMA subsystem.  It previously served
> to dump the measurement list during the kexec 'load' operation, but this
> functionality has been replaced by an alternative approach in this patch
> series.
> 
> Remove the unused ima_dump_measurement_list function from the IMA
> subsystem, to ensure a cleaner and more maintainable code.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Have you compiled the code and tested after applying each patch? 
Removing the caller before removing the code should have resulted in a
warning.

-- 
thanks,

Mimi

