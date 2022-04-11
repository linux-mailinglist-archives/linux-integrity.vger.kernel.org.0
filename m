Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B04FBB07
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Apr 2022 13:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbiDKLfo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Apr 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbiDKLfh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Apr 2022 07:35:37 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A173C4578F;
        Mon, 11 Apr 2022 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1649676804; x=1681212804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MikfRTUlq4K03S1l0EVzlzVMymBkQMOzwPYGxEdj2j8=;
  b=QQhPavLIqamde4Hp83JKWiatcjXzFO5uKb6Ld4LBEEDlQzUNoQWBiWrE
   gJyrwFSs2p0j016+wM45sD3MPxgX2akE5jJbn9NRzxA+Du7QoDgZduv+p
   NHNg1GpGNh8INCd/9RFifqcbIzh+EhUdOCAT0Xyzkzz5Jo2f6/cbWPzC2
   E=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="289851685"
X-IronPort-AV: E=Sophos;i="5.90,251,1643670000"; 
   d="scan'208";a="289851685"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 13:33:21 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 11 Apr 2022 13:33:20 +0200 (CEST)
Received: from [10.160.241.183] (172.23.8.247) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 13:33:19 +0200
Message-ID: <d6878e6c-e949-3c38-f370-0aa0ac8ca226@infineon.com>
Date:   Mon, 11 Apr 2022 13:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 4/4] tpm: Add YAML schema for the TPM TIS I2C options
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <peterhuewe@gmx.de>,
        <jarkko@kernel.org>, <jgg@ziepe.ca>, <amirmizi6@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>
References: <20220404081835.495-1-johannes.holland@infineon.com>
 <20220404081835.495-4-johannes.holland@infineon.com>
 <1649088538.021063.1436944.nullmailer@robh.at.kernel.org>
From:   Johannes Holland <johannes.holland@infineon.com>
In-Reply-To: <1649088538.021063.1436944.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE813.infineon.com (172.23.29.39) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 04.04.2022 18:08, Rob Herring wrote:> On Mon, 04 Apr 2022 10:18:35 +0200, Johannes Holland wrote:
>> Add a YAML schema to support device tree bindings for the generic I2C
>> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
>> Specification for TPM 2.0 v1.04 Revision 14.
>>
>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>> ---
>>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 48 +++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
>>
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml: tpm@2e: compatible:1: 'tcg,tpm-tis-i2c' was expected
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.example.dt.yaml: tpm@2e: compatible: ['infineon,slb9673', 'nuvoton,npct75x', 'tcg,tpm-tis-i2c'] is too long
>         From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Sorry for the inconvenience. This will be fixed in the next patch.

Thanks,
Johannes
