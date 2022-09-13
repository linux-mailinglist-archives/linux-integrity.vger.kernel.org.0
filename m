Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A605B788D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbiIMRpW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiIMRov (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0D796AF
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 09:40:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DGa6Tk022613;
        Tue, 13 Sep 2022 16:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cSbHW68v9pAbnkzSsQRyCfRDKCm3uv9u9Mp7JyWgBDM=;
 b=cMSt1VkoG6NKEzL/7dfFjTGSj2ce2KVHzH3uVf7yH4+8kx1rZoXaHeVS4AcwSGS4pq5S
 3IldWXFTOD/QhUT8SV+5PGmTRGNbxacUh09FLAS8FHFSyjIN/IZmNcuzYIdGFCKhkYzf
 gb/vbQ2yZ8guwDFGz7oiw0nJf/3yPq4M74usTOF2kt//vnjSHBaF8+ldapJm7BHKrWaw
 x+5c9d5LjzDnEq6plhagtKfVsqpHy2wNiWyJSz49k24KW3qE3p6TiB9iVLEgvrV6yOTc
 J6p/ikyNNEXwzkY21xg19HAj5mdcokRnLZ/2EuvdhHkLTcrsLyMVsCnPuFZCbBIBaZWU cA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjvw8hka9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:40:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DGamGP002361;
        Tue, 13 Sep 2022 16:40:37 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3jgj7aafyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:40:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DGebbr2753100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:40:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04769B2064;
        Tue, 13 Sep 2022 16:40:37 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C680FB205F;
        Tue, 13 Sep 2022 16:40:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 16:40:36 +0000 (GMT)
Message-ID: <df04328a-9489-efa5-7bcf-9655a371245e@linux.ibm.com>
Date:   Tue, 13 Sep 2022 12:40:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 03/12] Update configure.ac to address a
 couple of obsolete warnings
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-4-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-4-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eAZaBK2p5yIn-Q5qPkLGxRYJXcaWjpA9
X-Proofpoint-GUID: eAZaBK2p5yIn-Q5qPkLGxRYJXcaWjpA9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130075
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/6/22 15:50, Mimi Zohar wrote:
> Remove AC_PROG_LIBTOOL and AC_HEAD_STDC. Replace AC_HELP_STRING with
> AS_HELP_STRING.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
